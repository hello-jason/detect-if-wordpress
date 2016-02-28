# Is it WordPress?

Bash script to determine if the given URL is on WordPress

Usage:

```bash
bash wpdetect.sh --url example.com
```

## Developing

Included is another bash script that tosses several URLs at the detector, including vanilla WordPress, Bedrock WordPress, WordPress on WP Engine hosting, Magento, and custom applications.

Use the following to run a batch test, and add more sites to this file to solidify the checks:

```bash
bash urltests.sh
```
