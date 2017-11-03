+++
title = "Elements"
weight = 50
draft = true
+++

<h3 class="major">Hugo shortcodes in theme</h3>

<code>{&zwnj;{< socialLinks >}}</code> will get into {{< socialLinks >}} configured in <code>config.toml</code>.

<code>{&zwnj;{< gmaps  pb="\<sharecode\>" >}}</code> will get a google map 
{{< gmaps pb="!1m18!1m12!1m3!1d86456.59681285016!2d8.466675323953403!3d47.377433669132884!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x47900b9749bea219%3A0xe66e8df1e71fdc03!2zWsO8cmljaA!5e0!3m2!1sde!2sch!4v1488248947910" >}}

To get the pb parameter value, search the desired place on google maps and click the share button and copy/paste the pb parameter out of the iframe code.

<h3 class="major">Text</h3>

This is **bold** and this is __strong__. This is *italic* and this is _emphasized_.
This is <sup>superscript</sup> text and this is <sub>subscript</sub> text.
This is <u>underlined</u> and this is code: <code>for (;;) { ... }</code>. 
Finally, [this is a link to a markdown cheatsheet](https://beegit.com/markdown-cheat-sheet).

> Not all markdown syntax is allowed but you can mix most html tags into the markdown text.

---
## Heading Level 2
### Heading Level 3
#### Heading Level 4
##### Heading Level 5
###### Heading Level 6
---

#### Blockquote
> Fringilla nisl. Donec accumsan interdum nisi, quis tincidunt felis sagittis eget tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan faucibus. Vestibulum ante ipsum primis in faucibus lorem ipsum dolor sit amet nullam adipiscing eu felis.

#### Preformatted

    i = 0;

    while (!deck.isInOrder()) {
        print 'Iteration ' + i;
        deck.shuffle();
        i++;
    }

    print 'It took ' + i + ' iterations to sort the deck.';

<h3 class="major">Lists</h3>

#### Unordered
* Dolor pulvinar etiam.
* Sagittis adipiscing.
* Felis enim feugiat.

#### Ordered
1. Dolor pulvinar etiam.
2. Etiam vel felis viverra.
3. Felis enim feugiat.
4. Dolor pulvinar etiam.
5. Etiam vel felis lorem.
6. Felis enim et feugiat.

#### Icons
<ul class="icons">
	<li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
	<li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
	<li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
	<li><a href="#" class="icon fa-github"><span class="label">Github</span></a></li>
</ul>


#### Actions
<ul class="actions">
	<li><a href="#" class="button special">Default</a></li>
	<li><a href="#" class="button">Default</a></li>
</ul>
<ul class="actions vertical">
	<li><a href="#" class="button special">Default</a></li>
	<li><a href="#" class="button">Default</a></li>
</ul>
								
<h3 class="major">Table</h3>
#### Default

| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

<div class="table-wrapper">
	<table>
		<thead>
			<tr>
				<th>Name</th>
				<th>Description</th>
				<th>Price</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>Item One</td>
				<td>Ante turpis integer aliquet porttitor.</td>
				<td>29.99</td>
			</tr>
			<tr>
				<td>Item Two</td>
				<td>Vis ac commodo adipiscing arcu aliquet.</td>
				<td>19.99</td>
			</tr>
			<tr>
				<td>Item Three</td>
				<td> Morbi faucibus arcu accumsan lorem.</td>
				<td>29.99</td>
			</tr>
			<tr>
				<td>Item Four</td>
				<td>Vitae integer tempus condimentum.</td>
				<td>19.99</td>
			</tr>
			<tr>
				<td>Item Five</td>
				<td>Ante turpis integer aliquet porttitor.</td>
				<td>29.99</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2"></td>
				<td>100.00</td>
			</tr>
		</tfoot>
	</table>
</div>

<h4>Alternate</h4>
<div class="table-wrapper">
	<table class="alt">
		<thead>
			<tr>
				<th>Name</th>
				<th>Description</th>
				<th>Price</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>Item One</td>
				<td>Ante turpis integer aliquet porttitor.</td>
				<td>29.99</td>
			</tr>
			<tr>
				<td>Item Two</td>
				<td>Vis ac commodo adipiscing arcu aliquet.</td>
				<td>19.99</td>
			</tr>
			<tr>
				<td>Item Three</td>
				<td> Morbi faucibus arcu accumsan lorem.</td>
				<td>29.99</td>
			</tr>
			<tr>
				<td>Item Four</td>
				<td>Vitae integer tempus condimentum.</td>
				<td>19.99</td>
			</tr>
			<tr>
				<td>Item Five</td>
				<td>Ante turpis integer aliquet porttitor.</td>
				<td>29.99</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2"></td>
				<td>100.00</td>
			</tr>
		</tfoot>
	</table>
</div>
								

								
<h3 class="major">Buttons</h3>
<ul class="actions">
	<li><a href="#" class="button special">Special</a></li>
	<li><a href="#" class="button">Default</a></li>
</ul>
<ul class="actions">
	<li><a href="#" class="button">Default</a></li>
	<li><a href="#" class="button small">Small</a></li>
</ul>
<ul class="actions">
	<li><a href="#" class="button special icon fa-download">Icon</a></li>
	<li><a href="#" class="button icon fa-download">Icon</a></li>
</ul>
<ul class="actions">
	<li><span class="button special disabled">Disabled</span></li>
	<li><span class="button disabled">Disabled</span></li>
</ul>
								

								
<h3 class="major">Form</h3>
<form method="post" action="#">
	<div class="field half first">
		<label for="demo-name">Name</label>
		<input type="text" name="demo-name" id="demo-name" value="" placeholder="Jane Doe" />
	</div>
	<div class="field half">
		<label for="demo-email">Email</label>
		<input type="email" name="demo-email" id="demo-email" value="" placeholder="jane@untitled.tld" />
	</div>
	<div class="field">
		<label for="demo-category">Category</label>
		<div class="select-wrapper">
			<select name="demo-category" id="demo-category">
				<option value="">-</option>
				<option value="1">Manufacturing</option>
				<option value="1">Shipping</option>
				<option value="1">Administration</option>
				<option value="1">Human Resources</option>
			</select>
		</div>
	</div>
	<div class="field half first">
		<input type="radio" id="demo-priority-low" name="demo-priority" checked>
		<label for="demo-priority-low">Low</label>
	</div>
	<div class="field half">
		<input type="radio" id="demo-priority-high" name="demo-priority">
		<label for="demo-priority-high">High</label>
	</div>
	<div class="field half first">
		<input type="checkbox" id="demo-copy" name="demo-copy">
		<label for="demo-copy">Email me a copy</label>
	</div>
	<div class="field half">
		<input type="checkbox" id="demo-human" name="demo-human" checked>
		<label for="demo-human">Not a robot</label>
	</div>
	<div class="field">
		<label for="demo-message">Message</label>
		<textarea name="demo-message" id="demo-message" placeholder="Enter your message" rows="6"></textarea>
	</div>
	<ul class="actions">
		<li><input type="submit" value="Send Message" class="special" /></li>
		<li><input type="reset" value="Reset" /></li>
	</ul>
</form>
								
