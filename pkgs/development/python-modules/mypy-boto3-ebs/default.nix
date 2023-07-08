{ lib
, boto3
, buildPythonPackage
, fetchPypi
, pythonOlder
, typing-extensions
}:

buildPythonPackage rec {
  pname = "mypy-boto3-ebs";
  version = "1.28.0";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-DgfterQL/DbKRnvNL9I7fN8BrBwWlSP9fBNWPZUfFjs=";
  };

  propagatedBuildInputs = [
    boto3
    typing-extensions
  ];

  # Project has no tests
  doCheck = false;

  pythonImportsCheck = [
    "mypy_boto3_ebs"
  ];

  meta = with lib; {
    description = "Type annotations for boto3.s3";
    homepage = "https://github.com/youtype/mypy_boto3_builder";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
