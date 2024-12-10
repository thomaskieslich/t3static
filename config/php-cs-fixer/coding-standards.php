<?php

$config = \TYPO3\CodingStandards\CsFixerConfig::create();
$config->getFinder()
    ->ignoreVCSIgnored(true)
    ->in(realpath(__DIR__ . '/../../'));

$config->setParallelConfig(new PhpCsFixer\Runner\Parallel\ParallelConfig(4, 20));

$config->addRules([
    'single_line_comment_spacing' => true,
]);

return $config;
