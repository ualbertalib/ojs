{**
 * templates/issue/archive.tpl
 *
 * Copyright (c) 2013-2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Issue Archive.
 *
 *}
{strip}
{assign var="pageTitle" value="archive.archives"}
{include file="common/header.tpl"}
{/strip}

<div id="issues">
{**
* Custom Code By Jeremy for JPPS
*
*}
{if $currentJournal->getJournalInitials() == 'JPPS'}
<a target="JPPS" href="http://www.ualberta.ca/~csps/Journals/JournalArchives.htm"><b>To view our archives Volume 1 - Volume 10, No 3, 2007 please click here.</b></a>
{/if}

{if $currentJournal->getJournalInitials() == 'EBLIP'}		
			<script language="javascript">
			//popup("https://surveys.mcgill.ca/limesurvey/index.php?sid=43915&lang=en");

			{literal} 
			function popup(Site)			{
				window.open(Site,"survey","toolbar=yes,statusbar=yes, location=no,scrollbars=yes,resizable=yes");
			}
		   {/literal}
			</script>	
	{/if}
	
<a name="issues"></a>

{iterate from=issues item=issue}
	{if $issue->getYear() != $lastYear}
		{if !$notFirstYear}
			{assign var=notFirstYear value=1}
		{else}
			</div>
			<br />
			<div class="separator" style="clear:left;"></div>
		{/if}
		<div style="float: left; width: 100%;">
		<h3>{$issue->getYear()|escape}</h3>
		{assign var=lastYear value=$issue->getYear()}
	{/if}

	<div id="issue" style="clear:left;">
	{if $issue->getLocalizedFileName() && $issue->getShowCoverPage($locale) && !$issue->getHideCoverPageArchives($locale)}
		<div class="issueCoverImage"><a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}"><img src="{$coverPagePath|escape}{$issue->getFileName($locale)|escape}"{if $issue->getCoverPageAltText($locale) != ''} alt="{$issue->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}/></a>
		</div>
		<h4><a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">{$issue->getIssueIdentification()|escape}</a></h4>
		<div class="issueCoverDescription">{$issue->getLocalizedCoverPageDescription()|strip_unsafe_html|nl2br}</div>
	{else}
		<h4><a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">{$issue->getIssueIdentification()|escape}</a></h4>
		<div class="issueDescription">{$issue->getLocalizedDescription()|strip_unsafe_html|nl2br}</div>
	{/if}
	</div>

{/iterate}
{if $notFirstYear}<br /></div>{/if}

{if !$issues->wasEmpty()}
	{page_info iterator=$issues}&nbsp;&nbsp;&nbsp;&nbsp;
	{page_links anchor="issues" name="issues" iterator=$issues}
{else}
	{translate key="current.noCurrentIssueDesc"}
{/if}
</div>
{include file="common/footer.tpl"}

