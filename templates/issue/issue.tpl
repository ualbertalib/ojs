{**
 * templates/issue/issue.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Issue
 *
 *}
{foreach name=sections from=$publishedArticles item=section key=sectionId}
{if $section.title}<h4 class="tocSectionTitle">{$section.title|escape}</h4>{/if}
		{**
		 * Custom Code by Jeremy 
		 * Added IF statement
		 * Display blank instead of "abtract" for journal 63 in the table of contents
		 *}
		{if $currentJournal->getJournalId() =='63'}
			<p>
			If you have problems with opening or reading any of our archived articles, please go to the Centre for Constitutional Studies Website at: www.law.ualberta.ca/centres/ccs to locate the article or call our office at (780)492-5681.
			</p>
		{/if}
{foreach from=$section.articles item=article}
	{assign var=articlePath value=$article->getBestArticleId($currentJournal)}
	{assign var=articleId value=$article->getId()}

	{if $article->getLocalizedFileName() && $article->getLocalizedShowCoverPage() && !$article->getHideCoverPageToc($locale)}
		{assign var=showCoverPage value=true}
	{else}
		{assign var=showCoverPage value=false}
	{/if}

	{if $article->getLocalizedAbstract() == ""}
		{assign var=hasAbstract value=0}
	{else}
		{assign var=hasAbstract value=1}
	{/if}

	{if (!$subscriptionRequired || $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || $subscribedUser || $subscribedDomain || ($subscriptionExpiryPartial && $articleExpiryPartial.$articleId))}
		{assign var=hasAccess value=1}
	{else}
		{assign var=hasAccess value=0}
	{/if}

<table class="tocArticle">
<tr valign="top">
	<td class="tocArticleCoverImage{if $showCoverPage} showCoverImage{/if}">
		{if $showCoverPage}
			<div class="tocCoverImage">
				{if !$hasAccess || $hasAbstract}<a href="{url page="article" op="view" path=$articlePath}" class="file">{/if}
				<img src="{$coverPagePath|escape}{$article->getFileName($locale)|escape}"{if $article->getCoverPageAltText($locale) != ''} alt="{$article->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}/>
				{if !$hasAccess || $hasAbstract}</a>{/if}
			</div>
		{/if}
	</td>

	{call_hook name="Templates::Issue::Issue::ArticleCoverImage"}

	<td class="tocArticleTitleAuthors{if $showCoverPage} showCoverImage{/if}">
		<div class="tocTitle">
			{if !$hasAccess || $hasAbstract}
				<a href="{url page="article" op="view" path=$articlePath}">{$article->getLocalizedTitle()|strip_unsafe_html}</a>
			{else}
				{$article->getLocalizedTitle()|strip_unsafe_html}
			{/if}
		</div>
		<div class="tocAuthors">
			{if $article->getArticleId()==4565}
				<strong>Guest editors:</strong>
			{/if}
			{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
				{foreach from=$article->getAuthors() item=author name=authorList}
					
						{*
						 * Custom code by jeremy - add country
						 * 
						*}
					{if $article->getJournalId() == 14 || $article->getJournalId()==13}
						{$author->getFullName()|escape} <strong>{$author->getCountryLocalized()|escape}</strong>{if !$smarty.foreach.authorList.last},{/if}
					{else}
						{$author->getFullName()|escape} {if !$smarty.foreach.authorList.last},{/if}
					{/if}
				{/foreach}
			{else}
				&nbsp;
			{/if}
		</div>
	</td>

	<td class="tocArticleGalleysPages{if $showCoverPage} showCoverImage{/if}">
		<div class="tocGalleys">
			{if $hasAccess || ($subscriptionRequired && $showGalleyLinks)}
				{foreach from=$article->getGalleys() item=galley name=galleyList}
					{*
				* Custom code by jeremy - added google anayltics code
				* onClick="_gaq.push(['_trackEvent', 'PDF', 'Open', 'in-page viewer']);"  href="{url page="article"
				*}
				<a onClick="_gaq.push(['_trackEvent', 'PDF', 'Open', 'in-page viewer']);"  href="{url page="article" op="view" path=$articlePath|to_array:$galley->getBestGalleyId($currentJournal)}" class="file">{$galley->getGalleyLabel()|escape}</a>
					{if $subscriptionRequired && $showGalleyLinks && $restrictOnlyPdf}
						{if $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || !$galley->isPdfGalley()}
							<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
						{else}
							<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
						{/if}
					{/if}
				{/foreach}
				{if $subscriptionRequired && $showGalleyLinks && !$restrictOnlyPdf}
					{if $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN}
						<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
					{else}
						<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
					{/if}
				{/if}
			{/if}
		</div>
		<div class="tocPages">
			{$article->getPages()|escape}
		</div>
	</td>
</tr>
</table>
{call_hook name="Templates::Issue::Issue::Article"}
{/foreach}

{if !$smarty.foreach.sections.last}
<div class="separator"></div>
{/if}
{/foreach}

