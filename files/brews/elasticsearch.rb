class Elasticsearch < Formula
  homepage "http://www.elasticsearch.org"
  url "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.2.tar.gz"
  sha1 "ae381615ec7f657e2a08f1d91758714f13d11693"

  version '1.4.2-boxen1'

  depends_on :java => "1.7+"

  head do
    url "https://github.com/elasticsearch/elasticsearch.git"
    depends_on "maven" => :build
  end

  def cluster_name
    "elasticsearch_#{ENV["USER"]}"
  end

  def install
    if build.head?
      # Build the package from source
      system "mvn", "clean", "package", "-DskipTests"
      # Extract the package to the current directory
      system "tar", "--strip", "1", "-xzf", "target/releases/elasticsearch-*.tar.gz"
    end

    # Remove Windows files
    rm_f Dir["bin/*.bat"]
    rm_f Dir["bin/*.exe"]

    # Move libraries to `libexec` directory
    libexec.install Dir["lib/*.jar"]
    (libexec/"sigar").install Dir["lib/sigar/*.{jar,dylib}"]

    # Install everything else into package directory
    prefix.install Dir["*"]

    # Remove unnecessary files
    rm_f Dir["#{lib}/sigar/*"]
    if build.head?
      rm_rf "#{prefix}/pom.xml"
      rm_rf "#{prefix}/src/"
      rm_rf "#{prefix}/target/"
    end

    inreplace "#{bin}/elasticsearch.in.sh" do |s|
      # Configure ES_HOME
      s.sub!(%r{#\!/bin/sh\n}, "#!/bin/sh\n\nES_HOME=#{prefix}")
      # Configure ES_CLASSPATH paths to use libexec instead of lib
      s.gsub!(%r{ES_HOME/lib/}, "ES_HOME/libexec/")
    end

    inreplace "#{bin}/plugin" do |s|
      # Add the proper ES_CLASSPATH configuration
      s.sub!(/SCRIPT="\$0"/, %(SCRIPT="$0"\nES_CLASSPATH=#{libexec}))
      # Replace paths to use libexec instead of lib
      s.gsub!(%r{\$ES_HOME/lib/}, "$ES_CLASSPATH/")
    end
  end
end
