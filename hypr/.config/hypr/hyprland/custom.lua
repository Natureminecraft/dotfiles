-- Keeps workspaces 1 through x existing at all times
-- Fixed the workspaces bug
local x = 1

for i = 1, x do
  hl.workspace_rule({
    workspace = tostring(i),
    persistent = true
  })
end
