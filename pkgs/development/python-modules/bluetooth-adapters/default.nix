{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, poetry-core
, async-timeout
, dbus-next
, myst-parser
, pytestCheckHook
, sphinxHook
, sphinx-rtd-theme
}:

buildPythonPackage rec {
  pname = "bluetooth-adapters";
  version = "0.3.4";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "Bluetooth-Devices";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-bnFcqWM1kN2m3HMHJ5LgGJPxCXlgULu7kSl7RpKsVxc=";
  };

  postPatch = ''
    # Drop pytest arguments (coverage, ...)
    sed -i '/addopts/d' pyproject.toml
  '';

  outputs = [
    "out"
    "doc"
  ];

  nativeBuildInputs = [
    myst-parser
    poetry-core
    sphinx-rtd-theme
    sphinxHook
  ];

  propagatedBuildInputs = [
    async-timeout
    dbus-next
  ];

  pythonImportsCheck = [
    "bluetooth_adapters"
  ];

  checkInputs = [
    pytestCheckHook
  ];

  meta = with lib; {
    changelog = "https://github.com/bluetooth-devices/bluetooth-adapters/blob/main/CHANGELOG.md";
    description = "Tools to enumerate and find Bluetooth Adapters";
    homepage = "https://bluetooth-adapters.readthedocs.io/";
    license = licenses.asl20;
    maintainers = teams.home-assistant.members;
  };
}
