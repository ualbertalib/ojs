{**
 * templates/index/site.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Site index.
 *
 *}
{strip}
{if $siteTitle}
	{assign var="pageTitleTranslated" value=$siteTitle}
{/if}
{include file="common/uofaheader.tpl"}
{/strip}
<div class="slider-wrapper theme-default">
    <div class="ribbon"></div>
<div id="slider" class="nivoSlider">
<img src="{$baseUrl}/templates/images/custom/deakin.jpg"/>
<img src="{$baseUrl}/templates/images/custom/ijqm.jpg"/>
<img src="{$baseUrl}/templates/images/custom/alternative.jpg"/>
<img src="{$baseUrl}/templates/images/custom/constellations-slide.jpg"/>
<img src="{$baseUrl}/templates/images/custom/transcultural-slide.jpg"/>
<img src="{$baseUrl}/templates/images/custom/aps-slide.jpg"/>
<img src="{$baseUrl}/templates/images/custom/pharmacy-slide.jpg"/>
</div>
</div>
<div id="content">

<div id="welcome" class="box">
<p>
{if $intro}{$intro|nl2br}{/if}
</p> </div>
<div id="info" class="box">
	General inquiries may be sent to: Leah Vanderjagt, Digital Repository Services Librarian, University of Alberta Libraries /
	<a href="mailto:leahv@ualberta.ca">leahv@ualberta.ca</a>  
	Do you have a question about a particular journal? 
	If so, refer to the contact information found in the <a href="/index.php/index/about">About -- Contact</a> section on each journal's individual website.
	</div>
	<div id="rightSidebar"class="box">
		{call_hook|assign:"rightSidebarCode" name="Templates::Common::RightSidebar"}
		{$rightSidebarCode}
	</div>
<a name="journals"></a>
<div id="ejournals" class="box">
	<h2>Our Journals</h2>
{if $useAlphalist}
	
{/if}

{iterate from=journals item=journal}
{if $site->getSetting('showThumbnail')}
			{assign var="displayJournalThumbnail" value=$journal->getLocalizedSetting('journalThumbnail')}
			<div style="clear:left;">
			{if $displayJournalThumbnail && is_array($displayJournalThumbnail)}
				{assign var="altText" value=$journal->getLocalizedSetting('journalThumbnailAltText')}
				<div class="homepageImage"><a href="{url journal=$journal->getPath()}" class="action"><img src="{$journalFilesPath}{$journal->getId()}/{$displayJournalThumbnail.uploadName|escape:"url"}" {if $altText != ''}alt="{$altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} /></a></div>
			{/if}
			</div>
		{/if}
		{if $site->getSetting('showTitle')}
			<h3><a href="{url journal=$journal->getPath()}">{$journal->getLocalizedTitle()|escape}</a></h3>
		{/if}
		{if $site->getSetting('showDescription')}
			{if $journal->getLocalizedDescription()}
				<p>{$journal->getLocalizedDescription()|nl2br}</p>
			{/if}
		{/if}
		<p><a href="{url journal=$journal->getPath()}" class="action">{translate key="site.journalView"}</a> | <a href="{url journal=$journal->getPath() page="issue" op="current"}" class="action">{translate key="site.journalCurrent"}</a> | <a href="{url journal=$journal->getPath() page="user" op="register"}" class="action">{translate key="site.journalRegister"}</a></p>
	{/iterate}
{if $journals->wasEmpty()}
	{translate key="site.noJournals"}
{/if}

<div id="journalListPageInfo">{page_info iterator=$journals}</div>
<div id="journalListPageLinks">{page_links anchor="journals" name="journals" iterator=$journals}
</div>
</div>
</div>
{include file="common/uofafooter.tpl"}

