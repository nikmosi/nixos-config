{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnu-tar
    xz
  ];

  home.shellAliases = {
    # Extract: x=extract, v=verbose, f=file (auto-detects format)
    untar = "tar -xvf";

    # Create (xz): c=create, J=xz, v=verbose, f=file
    tarc = "tar -cJvf";

    # List content: t=list, v=verbose, f=file
    tarls = "tar -tvf";
  };
}
