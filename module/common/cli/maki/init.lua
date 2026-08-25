require("review")

maki.setup({
  always_thinking = "high",
  provider = {
    allowed_models = {
      "amd/DeepSeek-V4-Flash",
      "google/gemini-3.7-flash",
      "openai/gpt-5.6*",
      "opencode/*-free",
      "opencode-go/*",
      "openrouter/google/gemini-3.7-flash",
      "openrouter/openrouter/free",
    },
  },
  plugins = {
    task = {
      allow_model = true,
    },
    bash = {
      timeout_secs = 180,
    },
    index = {
      max_file_size_mb = 4,
    },
  },
})
