use inc::Module::Install;
name 'HTML-CSSInliner';
all_from 'lib/HTML/CSSInliner.pm';

requires 'CSS::Tiny' => 1.15;

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
