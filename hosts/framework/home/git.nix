{ vars, ... }:
{
  programs.git = {
    enable = true;
    userName = "${vars.username}";
    userEmail = "${vars.email}";
  };
}
