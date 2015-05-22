echo ">>> creating virtualenv"
virtualenv -p python .ve
source .ve/bin/activate
echo ">>> installing dependencies"
pip install pytest-cov lxml jdcal
echo ">>> perform coverage tests"
mkdir -p shippable/codecoverage
py.test --cov openpyxl --cov-report xml --junit-xml=shippable/codecoverage/results.xml
py.test --cov openpyxl --cov-report html

