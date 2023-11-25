const time = 1684929490;
const temperature = 292.87;
final weatherDataJson = {
  'dt': time,
  'feels_like': temperature,
};

const forecastTime = 1684951200;
const forecastSummary = 'Expect a day of partly cloudy with rain';

final forecastJson = {
  'dt': forecastTime,
  'summary': forecastSummary,
};

final weatherJson = {
  'current': weatherDataJson,
  'daily': [forecastJson],
};
