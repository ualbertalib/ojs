{**
 * templates/article/article.tpl
 *
 * Copyright (c) 2013-2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Article View.
 *}
{strip}
{if $galley}
	{assign var=pubObject value=$galley}
{else}
	{assign var=pubObject value=$article}
{/if}
{include file="article/header.tpl"}
{/strip}
{**
* Custom by Jeremy
* Adds the author names/author affiliation/superscripting
* also uses the getAuthor_Affiliation_SuperScript() from classes/article/Article.inc.php
* 
*}		
			   {php}
			
				
			     #$Auth_Afil_Sup = $this->_tpl_vars['article']->getAuthor_Affiliation_SuperScript() ;
				 $Auth_Afil_Sup = $this->get_template_vars('article')->getAuthor_Affiliation_SuperScript() ;
				 
				  #echo count($Auth_Afil_Sup) . '<br>';
				  #echo is_array($Auth_Afil_Sup) ? "yes" . '<br>' : "No"  . '<br>' ;
				   $Auth_ary = $Auth_Afil_Sup['AuthorName']  ;
				   $Affil_ary = $Auth_Afil_Sup['Affiliation'];
			       $Sup_ary = $Auth_Afil_Sup['Superscript']  ;
				   
			  	  #echo 'AuthorName' . count($Auth_ary) . '<br>' ;
				  #echo '<br><b>';
				  #print_r(array_keys($Auth_ary));
				  # echo '<br></b>';
				  #echo '<br><br>';
				  #  echo '<br><b>';
				  #print_r($Affil_ary);
				  #  echo '<br></b>';		
				  #echo  $Auth_ary[0] ;
				  
				  $Auth_str= "";
				  $counter = 0;	  
				  foreach($Auth_ary as $a){
				  	if (!empty($Auth_str)) {
					    
							$Auth_str .= ', ';
							
						}			
						$Auth_str .= $a;
						if (count($Auth_ary) > 1){
						 $Auth_str .= '<sup>' . ($Sup_ary[$counter]  ) . '</sup>';
						}
						  
						if (trim($Affil_ary[$counter]) != ""){
						  # if there only 1 author a superscript is not neccassary.
							if (count($Auth_ary) > 1){
						    $affil_str .= '<br> <sup>' . ($Sup_ary[$counter]  ). '</sup>' . $Affil_ary[$counter]; 
							}else{
							 $affil_str .= '<br>'. $Affil_ary[$counter]; 
							}
							
						}
						
						$counter +=1;			
				  }
				  #echo $Auth_str . '<br>';
				  #echo $affil_str;
				   
			  {/php}
  {** End CUSTOM *}

{if $galley}
	{if $galley->isHTMLGalley()}
		{$galley->getHTMLContents()}
	{elseif $galley->isPdfGalley()}
		{include file="article/pdfViewer.tpl"}
	{/if}
{else}
	<div id="topBar">
		{if is_a($article, 'PublishedArticle')}{assign var=galleys value=$article->getGalleys()}{/if}
		{if $galleys && $subscriptionRequired && $showGalleyLinks}
			<div id="accessKey">
				<img src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
				{translate key="reader.openAccess"}&nbsp;
				<img src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
				{if $purchaseArticleEnabled}
					{translate key="reader.subscriptionOrFeeAccess"}
				{else}
					{translate key="reader.subscriptionAccess"}
				{/if}
			</div>
		{/if}
	</div>
	{if $coverPagePath}
		<div id="articleCoverImage"><img src="{$coverPagePath|escape}{$coverPageFileName|escape}"{if $coverPageAltText != ''} alt="{$coverPageAltText|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}{if $width} width="{$width|escape}"{/if}{if $height} height="{$height|escape}"{/if}/>
		</div>
	{/if}
	{call_hook name="Templates::Article::Article::ArticleCoverImage"}
	<div id="articleTitle"><h3>{$article->getLocalizedTitle()|strip_unsafe_html}</h3></div>
	<div id="authorString">

		<em>
	{**
	* Custom by Jeremy
	* Displays the Author names and affiliations and superscripts
	*}
			{if $currentJournal->getJournalId() == 14}
				{php}echo $Auth_str . '<br>' . $affil_str ;{/php}	
			{else}
				{if $currentJournal->getJournalId() != 62}
				{$article->getAuthorString()|escape}
				 {/if}	
			 {/if}	
	{** End CUSTOM *}

</em>

	</div>
	<br />
	{if $article->getLocalizedAbstract()}
		<div id="articleAbstract">
		
		{**
   	     * Custom Code by Jeremy  Change "ABSTRACT" to blank (journal 62)
	    *}

		{if $currentJournal->getJournalId() != 62}
			<h4>{translate key="article.abstract"}</h4>
		{else}
			
		{/if}	
		{** End CUSTOM *}
		
		
		<br />
		<div>{$article->getLocalizedAbstract()|strip_unsafe_html|nl2br}</div>
		<br />
		</div>
	{/if}

	{if $article->getLocalizedSubject()}
		<div id="articleSubject">
		<h4>{translate key="article.subject"}</h4>
		<br />
		<div>{$article->getLocalizedSubject()|escape}</div>
		<br />
		</div>
	{/if}
	
	{**
		 *  Custom to show reference by Jeremy
		 *  Example: J Pharm Pharm Sci, 10 (2); 23-28, 2007
		 *}	
	
	 {php}
		         $vol = $this->_tpl_vars['issue']->getData('volume');
		         $num = $this->_tpl_vars['issue']->getData('number');
		        $year = $this->_tpl_vars['issue']->getData('year');  
		$journalTitle = $this->_tpl_vars['siteTitle']; 
		
	    $this->assign('volume',$vol);
		$this->assign('number',$num);
		$this->assign('issueYear',$year);
		$this->assign('journalTitle',$journalTitle);
	 {/php}
	 
	 {if $currentJournal->getJournalId() == 14}
	 <!--- {$journalTitle|escape} ---> J Pharm Pharm Sci, {$volume|escape} ({$number|escape}): {$article->getPages()|escape}{if $article->getPages()},{/if} {$issueYear|escape}
	 {/if}
	
	
	

	{if (!$subscriptionRequired || $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || $subscribedUser || $subscribedDomain)}
		{assign var=hasAccess value=1}
	{else}
		{assign var=hasAccess value=0}
	{/if}

	{if $galleys}
		<div id="articleFullText">
		<h4>{translate key="reader.fullText"}</h4>
		{if $hasAccess || ($subscriptionRequired && $showGalleyLinks)}
			{foreach from=$article->getGalleys() item=galley name=galleyList}
				<a href="{url page="article" op="view" path=$article->getBestArticleId($currentJournal)|to_array:$galley->getBestGalleyId($currentJournal)}" class="file" {if $galley->getRemoteURL()}target="_blank"{else}target="_parent"{/if}>{$galley->getGalleyLabel()|escape}</a>
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
		{else}
			&nbsp;<a href="{url page="about" op="subscriptions"}" target="_parent">{translate key="reader.subscribersOnly"}</a>
		{/if}
		</div>
	{/if}

	{if $citationFactory->getCount()}
		<div id="articleCitations">
		<h4>{translate key="submission.citations"}</h4>
		<br />
		<div>
			{iterate from=citationFactory item=citation}
				<p>{$citation->getRawCitation()|strip_unsafe_html}</p>
			{/iterate}
		</div>
		<br />
		</div>
	{/if}
{/if}

{foreach from=$pubIdPlugins item=pubIdPlugin}
	{if $issue->getPublished()}
		{assign var=pubId value=$pubIdPlugin->getPubId($pubObject)}
	{else}
		{assign var=pubId value=$pubIdPlugin->getPubId($pubObject, true)}{* Preview rather than assign a pubId *}
	{/if}
	{if $pubId}
		<br />
		<br />
		{$pubIdPlugin->getPubIdDisplayType()|escape}: {if $pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}<a id="pub-id::{$pubIdPlugin->getPubIdType()|escape}" href="{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}">{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}</a>{else}{$pubId|escape}{/if}
	{/if}
{/foreach}
{call_hook name="Templates::Article::MoreInfo"}
{include file="article/comments.tpl"}

{include file="article/footer.tpl"}
