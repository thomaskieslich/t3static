<?php


use a9f\Fractor\Configuration\FractorConfiguration;
use a9f\FractorComposerJson\AddPackageToRequireDevComposerJsonFractor;
use a9f\FractorComposerJson\ValueObject\PackageAndVersion;

return FractorConfiguration::configure()
    ->withPaths([__DIR__ . '/var/www/html/packages/sitepackage'])
    ->withConfiguredRule(
        AddPackageToRequireDevComposerJsonFractor::class,
        [new PackageAndVersion('vendor1/package3', '^3.0')]
    );
