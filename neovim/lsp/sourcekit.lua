return {
	cmd = { "xcrun", "sourcekit-lsp" },
	filetypes = { "swift" },
	root_markers = {
		"buildServer.json",
		"Package.swift",
		".xcodeproj",
		".xcworkspace",
		"compile_commands.json",
		".git",
	},
	capabilities = {
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
		},
	},
}
