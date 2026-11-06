return {
  -- pyright's pull-diagnostics race on startup (empty "unchanged" result overwrites the real one):
  -- don't advertise pull support so pyright pushes diagnostics instead.
  before_init = function(params)
    params.capabilities.textDocument.diagnostic = nil
  end,
}
