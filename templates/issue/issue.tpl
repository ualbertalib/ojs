{**
 * templates/issue/issue.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
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
	
<table class="tocArticle" width="100%">
<tr valign="top">
	{if $article->getLocalizedFileName() && $article->getLocalizedShowCoverPage() && !$article->getHideCoverPageToc($locale)}
	<td rowspan="2">
		<div class="tocArticleCoverImage">
		<a href="{url page="article" op="view" path=$articlePath}" class="file">
		<img src="{$coverPagePath|escape}{$article->getFileName($locale)|escape}"{if $article->getCoverPageAltText($locale) != ''} alt="{$article->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}/></a></div>
	</td>
	{/if}
	{call_hook name="Templates::Issue::Issue::ArticleCoverImage"}

	{if $article->getLocalizedAbstract() == ""}
		{assign var=hasAbstract value=0}
	{else}
		{assign var=hasAbstract value=1}
	{/if}

	{assign var=articleId value=$article->getId()}
	{if (!$subscriptionRequired || $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || $subscribedUser || $subscribedDomain || ($subscriptionExpiryPartial && $articleExpiryPartial.$articleId))}
		{assign var=hasAccess value=1}
	{else}
		{assign var=hasAccess value=0}
	{/if}

	<td class="tocTitle">{if !$hasAccess || $hasAbstract}<a href="{url page="article" op="view" path=$articlePath}">{$article->getLocalizedTitle()|strip_unsafe_html}</a>{else}{$article->getLocalizedTitle()|strip_unsafe_html}{/if}</td>
	<td class="tocGalleys">
		
		{**
		 * Custom Code by Jeremy 
		 * Added IF statement
		 * Display blank instead of "abtract" for journal 62 (deakin) in the table of contents
		 *}
		{if $currentJournal->getJournalId() !='62'}
			{if !$hasAccess || $hasAbstract}<a href="{url page="article" op="view" path=$articlePath}" class="file">{if $hasAbstract}{translate key=article.abstract}{else}{translate key="article.details"}{/if}</a>{/if}
		{else}
			
		{/if}
		
		{** END CUSTOM *}
		
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
	</td>
</tr>
  {php}
   unset($Country);
   $Country = array();
   
   {/php}

<tr>
	<td class="tocAuthors">
		{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
			{if $article->getArticleId()==4565}
				<strong>Guest editors:</strong>
			{/if}
			{foreach from=$article->getAuthors() item=author name=authorList}
				{$author->getFullName()|escape}{if !$smarty.foreach.authorList.last},{/if}
				   {if $article->getJournalId() == 14 || $article->getJournalId()==13}
					   <!--{$author->getCountryLocalized()|escape} -->
					   
					   {php}
					     $Country[] = $this->_tpl_vars['author']->getCountryLocalized();
					   {/php}
					          
					   {/if}			
			{/foreach}
			  {if $article->getJournalId() == 14 || $article->getJournalId()==13}
			   {php}
			    $dedup_Countryarray = array_unique($Country);
			    //$dedup_Countryarray = array_values($dedup_Countryarray);
			    $this->assign('dedup_Countryarray',$dedup_Countryarray);
			   {/php}
			   {*{foreach from=$dedup_Countryarray item=country name=countrylist}  
			    <b>{$country|escape}{if (!$smarty.foreach.countrylist.last) },{/if}</b>
			   {/foreach} *}
			   
			   {* Below displays the country name *}			   
			   {section loop=$dedup_Countryarray name=country }
				{if $dedup_Countryarray[$smarty.section.country.index] !=""}
				<b>{$dedup_Countryarray[country]|escape}
				{* Only display a comma if there is nothing else in the array*}
						{if (!$smarty.section.country.last)}
							{if ($dedup_Countryarray[$smarty.section.country.index_next] != "")},{/if}
						{/if}</b>
				{/if}
				
			   {/section}
			  {/if}
		{else}
			&nbsp;
		{/if}
	</td>
	<td class="tocPages">{$article->getPages()|escape}</td>
</tr>
</table>
{call_hook name="Templates::Issue::Issue::Article"}
{/foreach}

{if !$smarty.foreach.sections.last}
<div class="separator"></div>
{/if}
{/foreach}

