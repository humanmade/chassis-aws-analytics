# Local AWS Analytics

This extension sets up two minimal services, one for Cognito and one for Pinpoint to allow you to test Pinpoint analytics locally.

It is based on the [`humanmade/local-cognito`](https://github.com/humanmade/local-cognito) and [`humanmade/local-pinpoint`](https://github.com/humanmade/local-pinpoint) docker images.

The plugin for using AWS analytics with WordPress is [humanmade/analytics](https://github.com/humanmade/analytics).

## Cognito

The Cognito service runs at `http://vagrant.local:33670` unless you have modified your `hosts`.

Supported endpoints are:

- `GetId`
- `GetCredentialsForId`

## Pinpoint

The Cognito service runs at `http://vagrant.local:33671` unless you have modified your `hosts`.

Supported endpoints are:

- `UpdateEndpoint`
- `PutEvents`
