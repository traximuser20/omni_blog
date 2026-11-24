// PreToolUse hook validation script
module.exports = () => {
  // Validate command execution permissions
  if (!process.env.RUBY_ENV) {
    throw new Error('RUBY_ENV not set - required for tool execution');
  }
  return true;
};