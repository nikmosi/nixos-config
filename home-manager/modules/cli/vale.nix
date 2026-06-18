_: {
  xdg.configFile."vale/.vale.ini" = {
    force = true;
    text = ''
      StylesPath = styles
      MinAlertLevel = suggestion
      Packages = write-good

      [*.md]
      BasedOnStyles = write-good
    '';
  };
}
