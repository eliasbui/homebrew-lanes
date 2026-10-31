cask "lanes" do
  version "0.12.0"
  sha256 "5c8f085e345686f14ac788c50cf5d7fe393d1a77f4f48e3cfade7aa0332c7e17"

  url "https://github.com/eliasbui/lanes/releases/download/v#{version}/Lanes-#{version}-macos.zip"
  name "Lanes"
  desc "Multi-connection download manager with browser capture and resume"
  homepage "https://github.com/eliasbui/lanes"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Lanes.app"

  # Signed ad hoc and not notarized: without this Gatekeeper refuses to open it.
  postflight_steps do
    if_path_exists "{{appdir}}/Lanes.app" do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Lanes.app"]
    end
  end

  # The login item that "Mở cùng máy tính" adds goes with the app.
  uninstall launchctl: "com.eliasbui.lanes",
            quit:      "com.eliasbui.lanes"

  zap trash: "~/Library/Application Support/Lanes"
end
