{ ... }:
{
  security = {
    rtkit.enable = true;
    pam.services = {
      greetd.fprintAuth = true;
      sudo.fprintAuth = true;
      login.fprintAuth = true;
    };
  };
}
