{ config, lib, pkgs, ...}:
{
    
  home.packages = with pkgs;
    let jupyterWithPackages = 
      jupyter.override {
        definitions = {
          python3 = let env = (python3.withPackages(ps: with ps; [numpy scipy sympy matplotlib ipykernel ]));
          in {
            displayName = "Python 3";
            argv = ["${env.interpreter}" "-m" "ipykernel_launcher" "-f" "{connection_file}"];
            language = "python";
            logo32 = "${env.sitePackages}/ipykernel/resources/logo-32x32.png";
            logo64 = "${env.sitePackages}/ipykernel/resources/logo-64x64.png";
          };
        };
      }; in [
        jupyterWithPackages
      ];
}