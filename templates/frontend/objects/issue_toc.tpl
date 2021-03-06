{**
 * templates/frontend/objects/issue_toc.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Copyright (c) 2022 OPTIMETA project
 * Copyright (c) 2022 Daniel Nüst
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief View of an Issue which displays a full table of contents, with an added hook at the end.
 *
 * @uses $issue Issue The issue
 * @uses $issueTitle string Title of the issue. May be empty
 * @uses $issueSeries string Vol/No/Year string for the issue
 * @uses $issueGalleys array Galleys for the entire issue
 * @uses $hasAccess bool Can this user access galleys for this context?
 * @uses $publishedSubmissions array Lists of articles published in this issue
 *   sorted by section.
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 * @uses $heading string HTML heading element, default: h2
 *}


{if $activeTheme->getOption('parentName') == 'defaultthemeplugin'}

{if !$heading}
	{assign var="heading" value="h2"}
{/if}
{assign var="articleHeading" value="h3"}
{if $heading == "h3"}
	{assign var="articleHeading" value="h4"}
{elseif $heading == "h4"}
	{assign var="articleHeading" value="h5"}
{elseif $heading == "h5"}
	{assign var="articleHeading" value="h6"}
{/if}

<div class="obj_issue_toc">

	{* Indicate if this is only a preview *}
	{if !$issue->getPublished()}
		{include file="frontend/components/notification.tpl" type="warning" messageKey="editor.issues.preview"}
	{/if}

	{* Issue introduction area above articles *}
	<div class="heading">

		{* Issue cover image *}
		{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
		{if $issueCover}
			<a class="cover" href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
				{capture assign="defaultAltText"}
					{translate key="issue.viewIssueIdentification" identification=$issue->getIssueIdentification()|escape}
				{/capture}
				<img src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:$defaultAltText}">
			</a>
		{/if}

		{* Description *}
		{if $issue->hasDescription()}
			<div class="description">
				{$issue->getLocalizedDescription()|strip_unsafe_html}
			</div>
		{/if}

		{* PUb IDs (eg - DOI) *}
		{foreach from=$pubIdPlugins item=pubIdPlugin}
			{assign var=pubId value=$issue->getStoredPubId($pubIdPlugin->getPubIdType())}
			{if $pubId}
				{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
				<div class="pub_id {$pubIdPlugin->getPubIdType()|escape}">
					<span class="type">
						{$pubIdPlugin->getPubIdDisplayType()|escape}:
					</span>
					<span class="id">
						{if $doiUrl}
							<a href="{$doiUrl|escape}">
								{$doiUrl}
							</a>
						{else}
							{$pubId}
						{/if}
					</span>
				</div>
			{/if}
		{/foreach}

		{* Published date *}
		{if $issue->getDatePublished()}
			<div class="published">
				<span class="label">
					{translate key="submissions.published"}:
				</span>
				<span class="value">
					{$issue->getDatePublished()|date_format:$dateFormatShort}
				</span>
			</div>
		{/if}
	</div>

	{* Full-issue galleys *}
	{if $issueGalleys}
		<div class="galleys">
			<{$heading} id="issueTocGalleyLabel">
				{translate key="issue.fullIssue"}
			</{$heading}>
			<ul class="galleys_links">
				{foreach from=$issueGalleys item=galley}
					<li>
						{include file="frontend/objects/galley_link.tpl" parent=$issue labelledBy="issueTocGalleyLabel" purchaseFee=$currentJournal->getData('purchaseIssueFee') purchaseCurrency=$currentJournal->getData('currency')}
					</li>
				{/foreach}
			</ul>
		</div>
	{/if}

	{* Articles *}
	<div class="sections">
	{foreach name=sections from=$publishedSubmissions item=section}
		<div class="section">
		{if $section.articles}
			{if $section.title}
				<{$heading}>
					{$section.title|escape}
				</{$heading}>
			{/if}
			<ul class="cmp_article_list articles">
				{foreach from=$section.articles item=article}
					<li>
						{include file="frontend/objects/article_summary.tpl" heading=$articleHeading}
					</li>
				{/foreach}
			</ul>
		{/if}
		</div>
	{/foreach}

	{call_hook name="Templates::Issue::TOC::Main"}
	</div><!-- .sections -->
</div>

{/if} {* defaultthemeplugin *}

{* https://github.com/pkp/pragma/blob/main/templates/frontend/objects/issue_toc.tpl *}
{if $activeTheme->getOption('parentName') == 'pragmathemeplugin'}

<div class="row">
	<header class="col-sm-8 issue">
		{if $requestedOp === "index"}
			<p class="metadata">{translate key="journal.currentIssue"}</p>
		{/if}
		{strip}
		{capture name="issueMetadata"}
			{if $issue->getShowVolume() || $issue->getShowNumber()}
				{if $issue->getShowVolume()}
					<span class="issue__volume">{translate key="issue.volume"} {$issue->getVolume()|escape}{if $issue->getShowNumber()}, {/if}</span>
				{/if}
				{if $issue->getShowNumber()}
					<span class="issue__number">{translate key="issue.no"} {$issue->getNumber()|escape}. </span>
				{/if}
			{/if}
			{if $issue->getShowTitle()}
				<br/><span class="issue__title">{$issue->getLocalizedTitle()|escape}</span>
			{/if}
		{/capture}

		{if $requestedPage === "issue" && $smarty.capture.issueMetadata|trim !== ""}
			<h1 class="issue__header">
				{$smarty.capture.issueMetadata}
			</h1>
		{elseif $smarty.capture.issueMetadata|trim !== ""}
			<h2 class="issue__title">
				{$smarty.capture.issueMetadata}
			</h2>
		{/if}

		{if $issue->getDatePublished()}
			<p class="metadata">{translate key="submissions.published"} {$issue->getDatePublished()|date_format:$dateFormatLong}</p>
		{/if}
		{if $issue->getLocalizedDescription()}
			<div class="issue-desc">
				{assign var=stringLenght value=280}
				{assign var=issueDescription value=$issue->getLocalizedDescription()|strip_unsafe_html}
				{if $issueDescription|strlen <= $stringLenght || $requestedPage == 'issue'}
					{$issueDescription}
				{else}
					{$issueDescription|substr:0:$stringLenght|mb_convert_encoding:'UTF-8'|replace:'?':''|trim}…
					<p>
						<a class="btn btn-secondary"
						   href="{url op="view" page="issue" path=$issue->getBestIssueId()}">{translate key="issue.fullIssue"}</a>
					</p>
				{/if}
			</div>
		{/if}
		{/strip}
	</header>
</div>

{assign var=contentTableInserted value=false}
{foreach name=sections from=$publishedSubmissions item=section key=sectionNumber}
	{if $section.articles}
		<hr/>
		<section class="issue-section">
			{if !$contentTableInserted}
				<h3 class="issue-section__toc-title">Table of contents</h3>
				{assign var=contentTableInserted value=true}
			{/if}
			<header class="issue-section__header">
				<h3 class="issue-section__title">{$section.title|escape}</h3>
			</header>
			<ol class="issue-section__toc">
				{foreach from=$section.articles item=article}
					<li class="issue-section__toc-item">
						{include file="frontend/objects/article_summary.tpl"}
					</li>
				{/foreach}
			</ol>
		</section>
	{/if}

	{call_hook name="Templates::Issue::TOC::Main"}
{/foreach}

{/if} {* pragmathemeplugin *}
