local java17 = vim.fn.systemlist({ "mise", "where", "java@temurin-17" })[1]
local java21 = vim.fn.systemlist({ "mise", "where", "java@temurin-21" })[1]
local java25 = vim.fn.systemlist({ "mise", "where", "java@temurin-25" })[1]

local settings = {
  java = {
    eclipse = { downloadSources = true },
    import = { gradle = { enabled = true, java = { home = java17 } } },
    maven = { downloadSources = true },
    configuration = {
      runtimes = {
        { name = "JavaSE-17", path = java17 },
        { name = "JavaSE-21", path = java21 },
        { name = "JavaSE-25", path = java25, default = true },
      },
    },
  },
}

return {
  cmd_env = { JAVA_HOME = java25 },
  cmd = function(dispatchers, config)
    local args = {
      "jdtls",
      "-data",
      vim.fs.joinpath(vim.fn.stdpath("data"), "jdtls", vim.fn.sha256(config.root_dir)),
    }
    for arg in (vim.env.JDTLS_JVM_ARGS or ""):gmatch("%S+") do
      args[#args + 1] = "--jvm-arg=" .. arg
    end
    return vim.lsp.rpc.start(args, dispatchers, {
      cwd = config.cmd_cwd,
      env = config.cmd_env,
      detached = config.detached,
    })
  end,
  init_options = { settings = settings },
  settings = settings,
}
