cask "lanes" do
  version "0.4.0"
  sha256 "29fba7f4413bd24b76d2ad3d062b1178f79931985797f26a5b03e5640c2cd9d4"

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
