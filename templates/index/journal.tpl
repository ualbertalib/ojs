{**
 * templates/index/journal.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Journal index page.
 *
 *}
{strip}
{assign var="pageTitleTranslated" value=$siteTitle}
{include file="common/header.tpl"}
{/strip}

{if $journalDescription}
	<div>{$journalDescription}</div>
{/if}

{call_hook name="Templates::Index::journal"}

{if $homepageImage}
<br />
<div id="homepageImage"><img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" width="{$homepageImage.width|escape}" height="{$homepageImage.height|escape}" {if $homepageImageAltText != ''}alt="{$homepageImageAltText|escape}"{else}alt="{translate key="common.journalHomepageImage.altText"}"{/if} /></div>
{/if}

{if $additionalHomeContent}
<br />
{$additionalHomeContent}
{/if}

{if $enableAnnouncementsHomepage}
	{* Display announcements *}
	<div id="announcementsHome">
		<h3>{translate key="announcement.announcementsHome"}</h3>
		{include file="announcement/list.tpl"}	
		<table class="announcementsMore">
			<tr>
				<td><a href="{url page="announcement"}">{translate key="announcement.moreAnnouncements"}</a></td>
			</tr>
		</table>
	</div>
{/if}

{if $issue && $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
{**
		* Custom Code By Jeremy for EBLIP
		*
		*}
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
	{* Display the table of contents or cover page of the current issue. *}
	
	<h3>{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</h3>
	{include file="issue/view.tpl"}
{/if}

{include file="common/footer.tpl"}

