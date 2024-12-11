{ ... }:

{
  programs.fish =
    let
      stockly_repo = "$HOME/Stockly/Main";
    in
    {
      functions.cdr = ''cd "${stockly_repo}/$argv"'';
      shellInit = ''
        complete --no-files --exclusive --command cdr --arguments "(pushd ${stockly_repo}; __fish_complete_directories; popd)"
      '';
    };

  home.stateVersion = "24.11";
}
