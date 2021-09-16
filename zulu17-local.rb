cask "zulu17-local" do
  version "17.28.13,17.28.13-ca"

  if Hardware::CPU.intel?
    sha256 "d19f580d9197626dab0b242e9f4a4c1b88a3a9d55d18ac97474f73744c34bd79"

    url "https://cdn.azul.com/zulu/bin/zulu#{version.after_comma}-jdk#{version.before_comma}-macosx_x64.dmg",
        referer: "https://www.azul.com/downloads/zulu/zulu-mac/"
  else
    sha256 "2b15b8243781b8c8f03d0391ab5a2d93a380db88222dad5e0e90de0dcb472968"

    url "https://cdn.azul.com/zulu/bin/zulu#{version.after_comma}-jdk#{version.before_comma}-macosx_aarch64.dmg",
        referer: "https://www.azul.com/downloads/zulu/zulu-mac/"
  end
  name "Azul Zulu Java Standard Edition Development Kit"
  desc "Zulu OpenJDK 17"
  homepage "https://www.azul.com/products/core/"

  livecheck do
    url "https://api.azul.com/zulu/download/community/v1.0/bundles/latest/?jdk_version=#{version.major}&ext=dmg&os=macos&javafx=false"
    strategy :page_match do |page|
      match = page.match(%r{url"\s*:\s*"https:.*?/zulu(\d+(?:\.\d+)*-.*?)-jdk(\d+(?:\.\d+)*)-macos}i)
      "#{match[2]},#{match[1]}"
    end
  end

  depends_on macos: ">= :sierra"

  pkg "Double-Click to Install Azul Zulu JDK #{version.major}.pkg"

  uninstall pkgutil: "com.azulsystems.zulu.#{version.major}"
end
