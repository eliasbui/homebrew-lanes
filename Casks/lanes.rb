cask "lanes" do
  version "0.3.1"
  sha256 "a7591c9c104d1500a88681a115478bd32220d152191b87a23eb04fdc543bce10"

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
