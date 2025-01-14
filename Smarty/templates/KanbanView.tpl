{*<!--
/*********************************************************************************
** The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  coreBOS Open Source
 * The Initial Developer of the Original Code is coreBOS
 * All Rights Reserved.
 ********************************************************************************/
-->*}
{if $showDesert}
	{assign var='DESERTInfo' value='LBL_NO_DATA'|@getTranslatedString:$MODULE}
	{include file='Components/Desert.tpl'}
{else}
	<link rel="stylesheet" href="include/jkanban/jkanban.css">
	<link rel="stylesheet" href="modules/Vtiger/KanbanAPI/Kanban.css">
	<script type="text/javascript" src="include/jkanban/jkanban.js"></script>
	<script type="text/javascript" src="modules/Vtiger/KanbanAPI/Kanban.js"></script>
	<script type="text/javascript" src="include/js/dtlviewajax.js"></script>
	<script type="text/javascript" src="include/Webservices/WSClient.js"></script>
	<!-- List View's Buttons and Filters starts -->
	{assign var=SHOWPAGENAVIGATION value=false}
	{include file='ListViewFilter.tpl'}
	<!-- List View's Buttons and Filters ends -->
	<style>
		{foreach from=$kbLanes item=BOARD key=TITLE}
			{if !empty($BOARD.color)}
			.kanban-{$BOARD.color} {
				background-color: {$BOARD.color};
			}
			{/if}
		{/foreach}
	</style>
	{if isset($BALinks)}
		<div class="slds-page-header slds-m-top_small">
			<div class="slds-page-header__row">
				<div class="slds-page-header__col-title">
					<div class="slds-media">
						<div class="slds-media__body">
						{foreach from=$BALinks item=$i}
							<a class="slds-button slds-button_neutral" href="{$i->linkurl}">
								{$i->linklabel}
							</a>
						{/foreach}
						</div>
					</div>
				</div>
			</div>
		</div>
	{/if}
	<span>
	<div id="{{$kanbanID}}" style="max-width: 96vw; min-height:105vh;padding: 20px 0;"></div>
	<span id="{$kanbanID}Scroll"></span>
	</span>
	<script>
	var currentKanbanID = '{$kanbanID}';
	var {$kanbanID}Info = {$kanbanBoardInfo};
	var {$kanbanID} = new jKanban({
		element: '#{$kanbanID}',
		gutter: '10px',
		widthBoard: 'kanbanboard slds-card',
		itemHandleOptions:{
			enabled: false,
		},
		dropEl: function(el, target, source, sibling){
			kbUpdateAfterDrop(el, target);
		},
		itemAddOptions: {
			enabled: false,
			footer: false
		},
		boards: [
		{foreach from=$kbLanes item=BOARD key=TITLE}
		{
			id: '{$BOARD.id}',
			mod: 'Accounts',
			title: `{include file="Components/Kanban/KanbanHeader.tpl"}`,
			class: '{if !empty($BOARD.color)}kanban-{$BOARD.color}{/if}',
			item: []
		},
		{/foreach}
		]
	});
	kanbanRefresh('{$kanbanID}');
	kanbanSetupInfiniteScroll('{$kanbanID}');
	let lanefield = '{$lanefield}';
	let userwsid = {$USERSWSID};
	let currentStatus = '';
	let cbConn = new Vtiger_WSClient('');
	</script>
{/if}