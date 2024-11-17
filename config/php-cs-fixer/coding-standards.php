<?php

$config = \TYPO3\CodingStandards\CsFixerConfig::create();
$config->getFinder()
    ->ignoreVCSIgnored(true)
    ->in(realpath(__DIR__ . '/../../'))
;

return $config;
