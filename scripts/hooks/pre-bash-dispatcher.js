// PreToolUse hook for Bash commands
// Validates and potentially modifies arguments before tool execution

// Allow Rails commands to proceed, but validate that they're appropriate
// This is a basic implementation - adjust according to project needs

module.exports = function(context) {
  const { command, args } = context;

  // Allow common Rails commands
  const allowedCommands = ['bin/rails', 'rails', 'bundle', 'ruby'];

  if (!allowedCommands.some(allowed => command.includes(allowed))) {
    // If command is not allowed, throw an error
    throw new Error(`Bash command "${command}" is not permitted by PreToolUse hook`);
  }

  // Additional validation could go here
  // For example, checking that db:migrate is only run in appropriate contexts

  return true; // Allow the command to proceed
};