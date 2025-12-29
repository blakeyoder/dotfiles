#!/usr/bin/env python3
"""
Linear Feature Flag Detection Hook

This hook runs after Linear MCP get_issue calls to determine if a ticket
requires feature flag implementation. Provides simple yes/no guidance
based on ticket content analysis.

Workflow:
1. User says: "Let's start work on Linear Ticket 123"
2. Linear MCP fetches ticket data
3. Hook analyzes ticket for feature flag requirements
4. Hook responds: "YES - feature flag required" or "NO - no flag needed"
"""

import json
import sys
from typing import Dict, List, Tuple


class LinearFeatureFlagHook:
    def __init__(self, tool_data: Dict):
        self.tool_data = tool_data
        self.tool_result = tool_data.get('result', {})
        self.tool_name = tool_data.get('tool', {}).get('name', '')
        
        # Feature flag requirement keywords
        self.flag_keywords = [
            'needs to launch behind a feature flag',
            'feature flag required',
            'feature flag needed',
            'ff:',
            'gradual rollout',
            'behind feature flag',
            'feature toggle',
            'a/b test',
            'experiment',
            'phased rollout',
            'kill switch',
            'canary deployment',
            'progressive rollout',
            'beta feature',
            'experimental feature'
        ]
        
        # Labels that indicate feature flag requirement
        self.flag_labels = [
            'feature-flag-needed',       # Standard Berry Street label
            'needs-feature-flag',
            'feature-flag', 
            'gradual-rollout',
            'experiment',
            'a-b-test',
            'canary',
            'phased-rollout',
            'beta',
            'experimental'
        ]

    def extract_ticket_data(self) -> Dict:
        """Extract ticket information from Linear MCP result"""
        if not self.tool_result:
            return {}
            
        # The Linear MCP result should contain ticket data
        return self.tool_result

    def analyze_ticket_for_flags(self, ticket_data: Dict) -> Tuple[bool, List[str]]:
        """
        Analyze Linear ticket for feature flag requirements
        Returns (requires_flag, reasons)
        """
        if not ticket_data:
            return False, ['No ticket data available']
        
        reasons = []
        requires_flag = False
        
        # Get ticket fields
        title = ticket_data.get('title', '').lower()
        description = ticket_data.get('description', '').lower()
        identifier = ticket_data.get('identifier', 'Unknown')
        
        print(f"\n📋 Analyzing Linear Ticket: {identifier}")
        print(f"Title: {ticket_data.get('title', 'No title')}")
        
        # Debug: Show labels for troubleshooting
        labels = ticket_data.get('labels', [])
        if labels:
            label_names = [label.get('name') if isinstance(label, dict) else label for label in labels]
            print(f"Labels: {', '.join(label_names)}")
        else:
            print(f"Labels: None")
        
        # Check title and description for keywords
        for keyword in self.flag_keywords:
            if keyword.lower() in title or keyword.lower() in description:
                requires_flag = True
                reasons.append(f"Contains keyword: '{keyword}'")
        
        # Check labels if available
        labels = ticket_data.get('labels', [])
        label_names = []
        if labels:
            for label in labels:
                if isinstance(label, dict):
                    label_name = label.get('name', '').lower()
                    label_names.append(label_name)
                elif isinstance(label, str):
                    label_names.append(label.lower())
            
            # Check for standard feature flag label first
            if 'feature-flag-needed' in label_names:
                requires_flag = True
                reasons.append("Has standard label: 'feature-flag-needed' ⭐")
            
            # Check for other flag-related labels
            for flag_label in self.flag_labels:
                if flag_label != 'feature-flag-needed' and flag_label in label_names:
                    requires_flag = True
                    reasons.append(f"Has label: '{flag_label}'")
        
        # Check project context if available
        project = ticket_data.get('project', {})
        if project and isinstance(project, dict):
            project_name = project.get('name', '').lower()
            project_desc = project.get('description', '').lower()
            
            # Project-level flag indicators
            project_indicators = [
                'requires feature flags',
                'feature flag mandatory', 
                'gradual rollout project',
                'experimental features',
                'behind flags'
            ]
            
            for indicator in project_indicators:
                if indicator in project_name or indicator in project_desc:
                    requires_flag = True
                    reasons.append(f"Project requirement: '{indicator}'")
        
        # Additional heuristics for common patterns
        experimental_patterns = [
            r'\bexperiment\b',
            r'\ba/b\s+test\b', 
            r'\bcanary\b',
            r'\bbeta\b',
            r'\brollout\b'
        ]
        
        import re
        for pattern in experimental_patterns:
            if re.search(pattern, description, re.IGNORECASE) or re.search(pattern, title, re.IGNORECASE):
                requires_flag = True
                reasons.append(f"Experimental pattern detected: {pattern}")
                break  # Only add one experimental reason
        
        return requires_flag, reasons if reasons else ['No feature flag requirements detected']

    def generate_flag_name_suggestion(self, ticket_data: Dict) -> str:
        """Generate a suggested flag name based on ticket content"""
        if not ticket_data:
            return 'unknown-feature'
        
        title = ticket_data.get('title', '')
        identifier = ticket_data.get('identifier', '')
        
        # Extract meaningful words from title
        import re
        title_words = re.findall(r'\b[a-zA-Z]{3,}\b', title.lower())
        
        # Filter out common words
        common_words = {
            'the', 'and', 'for', 'with', 'from', 'new', 'add', 'create', 
            'update', 'fix', 'implement', 'build', 'make', 'feature'
        }
        meaningful_words = [word for word in title_words if word not in common_words]
        
        # Generate flag name
        if len(meaningful_words) >= 2:
            flag_name = '-'.join(meaningful_words[:3])
        elif len(meaningful_words) == 1:
            flag_name = f"{meaningful_words[0]}-feature"
        else:
            # Fallback to identifier
            flag_name = identifier.lower().replace('-', '-')
        
        return flag_name

    def suggest_rollout_strategy(self, ticket_data: Dict, requires_flag: bool) -> str:
        """Suggest appropriate rollout strategy"""
        if not requires_flag:
            return "standard_deployment"
        
        title = ticket_data.get('title', '').lower()
        description = ticket_data.get('description', '').lower()
        
        if 'experiment' in title or 'a/b' in description:
            return "split_testing"
        elif 'critical' in title or 'important' in title:
            return "careful_canary"
        elif 'api' in title or 'backend' in title:
            return "backend_first"
        else:
            return "gradual_percentage"

    def run(self) -> None:
        """Main hook execution"""
        print(f"\n🎯 Linear Feature Flag Detection Hook")
        print(f"Tool: {self.tool_name}")
        
        # Extract ticket data from MCP result
        ticket_data = self.extract_ticket_data()
        
        if not ticket_data:
            print(f"❌ No ticket data found in tool result")
            return
        
        # Analyze ticket for feature flag requirements
        requires_flag, reasons = self.analyze_ticket_for_flags(ticket_data)
        
        # Generate suggestions if flag is needed
        if requires_flag:
            print(f"\n✅ YES - FEATURE FLAG REQUIRED")
            print(f"🚩 Reasons:")
            for reason in reasons:
                print(f"   • {reason}")
            
            # Launch interactive flag creation workflow
            print(f"\n🚀 INTERACTIVE FLAG CREATION AVAILABLE")
            print(f"   Claude Code can now walk you through creating this flag interactively!")
            print(f"   ")
            print(f"   Next steps:")
            print(f"   1. Say: 'Create the feature flag interactively'")
            print(f"   2. Claude will prompt you for flag details")  
            print(f"   3. GrowthBook MCP will create the flag")
            print(f"   4. Code will be generated automatically")
            
            # Provide quick manual option too
            flag_name = self.generate_flag_name_suggestion(ticket_data)
            rollout_strategy = self.suggest_rollout_strategy(ticket_data, requires_flag)
            suggested_type = self._suggest_flag_type(ticket_data)
            
            print(f"\n📋 Quick Details (if you prefer manual creation):")
            print(f"   • Suggested flag name: '{flag_name}'")
            print(f"   • Suggested type: {suggested_type}")
            print(f"   • Rollout strategy: {rollout_strategy}")
            
            # Store ticket data for interactive session
            self._store_ticket_for_interactive_session(ticket_data)
        else:
            print(f"\n❌ NO - No feature flag required")
            print(f"📝 Analysis:")
            for reason in reasons:
                print(f"   • {reason}")
            print(f"\n✨ You can implement this feature with standard deployment")
        
        # Summary
        ticket_id = ticket_data.get('identifier', 'Unknown')
        ticket_url = ticket_data.get('url', '')
        
        print(f"\n📋 Summary:")
        print(f"   • Ticket: {ticket_id}")
        if ticket_url:
            print(f"   • URL: {ticket_url}")
        print(f"   • Feature Flag Required: {'YES' if requires_flag else 'NO'}")
        
        if requires_flag:
            print(f"   • Next Step: Implement GrowthBook feature flag before coding")
        else:
            print(f"   • Next Step: Proceed with standard implementation")

    def _suggest_flag_type(self, ticket_data: Dict) -> str:
        """Suggest appropriate flag type based on ticket content"""
        title_desc = (ticket_data.get('title', '') + ' ' + ticket_data.get('description', '')).lower()
        
        if any(word in title_desc for word in ['a/b', 'test', 'variant', 'experiment']):
            return 'string'  # For A/B testing
        elif any(word in title_desc for word in ['limit', 'count', 'number', 'threshold']):
            return 'number'  # For numeric controls
        elif any(word in title_desc for word in ['config', 'settings', 'complex']):
            return 'json'    # For complex configurations
        else:
            return 'boolean' # Default for simple toggles

    def _store_ticket_for_interactive_session(self, ticket_data: Dict) -> None:
        """Store ticket data for interactive flag creation session"""
        import os
        import tempfile
        
        # Store ticket data in temp file for interactive session
        temp_dir = tempfile.gettempdir()
        session_file = os.path.join(temp_dir, 'claude_code_ticket_session.json')
        
        try:
            with open(session_file, 'w') as f:
                json.dump(ticket_data, f, indent=2)
        except Exception as e:
            print(f"   Warning: Could not store session data: {e}")

    def _to_pascal_case(self, text: str) -> str:
        """Convert text to PascalCase"""
        words = text.replace('-', '_').split('_')
        return ''.join(word.capitalize() for word in words if word)


def main():
    """Hook entry point"""
    try:
        # Read tool data from stdin
        tool_data = json.load(sys.stdin)
        
        # Initialize and run hook
        hook = LinearFeatureFlagHook(tool_data)
        hook.run()
        
    except Exception as e:
        print(f"❌ Linear Feature Flag Hook Error: {e}")
        # Don't exit with error code as this might block the workflow
        # sys.exit(1)


if __name__ == "__main__":
    main()