<?php

use craft\helpers\App;

return [
  '*' => [
    'useDevServer' => App::env('CRAFT_ENVIRONMENT') === 'dev',
    'devServerPublic' => App::env('VITE_DEV_SERVER_URL') ?? 'https://localhost:3000',
    'manifestPath' => '@webroot/dist/.vite/manifest.json',
    'serverPublic' => App::env('PRIMARY_SITE_URL').'/dist/',
    'errorEntry' => 'assets/js/viteError.js',
    'cacheKeySuffix' => '',
    'devServerInternal' => '',
    'checkDevServer' => false,
    'includeReactRefreshShim' => false,
    'includeModulePreloadShim' => true,
    'criticalPath' => '@webroot/dist/criticalcss',
    'criticalSuffix' => '_critical.min.css',
  ],
];
