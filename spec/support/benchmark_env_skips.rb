# frozen_string_literal: true

# Benchmark baseline only (davidteren/mutineer-benchmarks). These examples fail
# on the benchmark box for environment reasons, before any mutation:
#   - three render mailer layouts that need compiled Vite assets (no yarn build)
#   - one decodes a webm fixture that this box's ffmpeg rejects
# mutineer refuses to score a suite that is not green, so skip them here.
BENCHMARK_ENV_SKIPS = [
  'EmailSubscription Callbacks generates token and delivers confirmation email',
  'User#mark_email_as_confirmed! when user is new confirms user and delivers welcome email',
  'MediaAttachment size limit validation accepts video files that are small enough',
  'Admin::AccountAction#save! sends email to target account user',
].freeze

RSpec.configure do |config|
  config.before do |example|
    skip 'benchmark box: needs compiled Vite assets or a newer ffmpeg' if BENCHMARK_ENV_SKIPS.include?(example.full_description)
  end
end
