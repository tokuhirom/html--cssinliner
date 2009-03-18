use Test::Base;
use HTML::CSSInliner;

plan tests => 1*blocks;

run {
    my $block = shift;

    my $got =  HTML::CSSInliner->inline(
        CSS::Tiny->read_string($block->css),
        $block->html,
    );
    is $got, $block->expected;
}

__END__

===
--- css
hr {
    color: yellow;
}
.foo {
    color: red;
    margin: 1px;
}
.bar {
    color: orange;
    margin: 2px;
}
--- html
<hr mmm="bbb" />
<div class="foo">class="bar"</div>
<div class="bar">class="foo"</div>
--- expected
<hr mmm="bbb"  style='color: yellow; border-color: yellow;' />
<div class="foo" style='color: red;margin: 1px;'>class="bar"</div>
<div class="bar" style='color: orange;margin: 2px;'>class="foo"</div>

===
--- css
hr { border-color: yellow; }
--- html
<hr>
--- expected
<hr style='color: yellow; border-color: yellow;' />

