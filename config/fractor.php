<?php
use a9f\Fractor\Configuration\FractorConfiguration;
use a9f\Typo3Fractor\Set\Typo3LevelSetList;

return FractorConfiguration::configure()
    ->withPaths([__DIR__ . '/packages'])
    ->withSkip([
        __DIR__ . '**/Build/node_modules/**',
        __DIR__ . '**/Resources/Public/bower_components/**',
        __DIR__ . '**/Resources/Public/vendor/**',
        __DIR__ . '**/Resources/Private/Schema/**',
        __DIR__ . '**/Resources/Private/Foundation/**', // dv-matthies-pagetemplate
        __DIR__ . '/vendor/davitec/pt-extlist/Documentation/**',
        __DIR__ . '/vendor/davitec/restler/Documentation/**',
    ])
    ->withSets([
        Typo3LevelSetList::UP_TO_TYPO3_13
    ]);
