{ ssbm
, slippi-desktop
, final
, prev }:

with final.pkgs; rec {

  wiimms-iso-tools = callPackage ./wit { };

  gecko = callPackage ./gecko { };

  powerpc-eabi-assembling = callPackage ./powerpc-eabi-as { };

  uncle-punch =
    callPackage ./uncle-punch { inherit ssbm gecko powerpc-eabi-assembling wiimms-iso-tools; };

  slippi-playback = callPackage ./slippi {
    playbackSlippi = true;
    slippiDesktopApp = slippi-desktop;
  };

  slippi-netplay = callPackage ./slippi { playbackSlippi = false; };

  slippi-netplay-chat-edition = slippi-netplay.overrideAttrs (oldAttrs: rec {
    pname = "slippi-ishiiruka-chat";
    version = "release/2.3.0";
    name = pname;

    src = fetchFromGitHub {
      owner = "project-slippi";
      repo = "Ishiiruka";
      rev = version;
      sha256 = "1rd449s00dqmngp3mrapg91k4hhg2kyc0kizc37vb4l2zswpkqah";
    };
  });

  gcmtool = callPackage ./gcmtool { };

}
