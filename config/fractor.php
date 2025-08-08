<?php
use a9f\Fractor\Configuration\FractorConfiguration;
use a9f\Typo3Fractor\Set\Typo3LevelSetList;

return FractorConfiguration::configure()
    ->withPaths([getenv('FULL_PACKAGE_PATH')])
    ->withSets([
        Typo3LevelSetList::UP_TO_TYPO3_12
    ]);
