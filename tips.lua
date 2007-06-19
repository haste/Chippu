--[[-------------------------------------------------------------------------
  Copyright (c) 2007, Trond A Ekseth
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:

      * Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
      * Redistributions in binary form must reproduce the above
        copyright notice, this list of conditions and the following
        disclaimer in the documentation and/or other materials provided
        with the distribution.
      * Neither the name of Chippu nor the names of its contributors may
        be used to endorse or promote products derived from this
        software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
---------------------------------------------------------------------------]]
-- We like locals
local tip = GameTooltip

local select = select
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor

--[[ Za Warudo!
--		GameTooltip
--]]
local gthook = CreateFrame("Frame", nil, tip)
local gtOnShow = function()
	local name, item = tip:GetItem()

	if(item) then
		local quality = select(3, GetItemInfo(item))
		local r, g, b = GetItemQualityColor(quality)

		tip:SetBackdropBorderColor(r, g, b)
		tip:SetBackdropColor(0, 0, 0, 1)
	end
end
gthook:SetScript("OnShow", gtOnShow)

--[[ Za Warudo!
--		ItemRefTooltip
--]]
local origs = {
	ItemRefTooltip = ItemRefTooltip:GetScript"OnTooltipSetItem",
	ShoppingTooltip1 = ShoppingTooltip1:GetScript"OnTooltipSetItem",
	ShoppingTooltip2 = ShoppingTooltip2:GetScript"OnTooltipSetItem",
}
local OnTooltipSetItem = function(self, ...)
	local orig = origs[self:GetName()]
	if(orig) then orig(self, ...) end

	local name, item = self:GetItem()
	if(item) then
		local quality = select(3, GetItemInfo(item))
		local r, g, b = GetItemQualityColor(quality)

		self:SetBackdropBorderColor(r, g, b)
		self:SetBackdropColor(0, 0, 0, 1)
	end
end

ItemRefTooltip:SetScript("OnTooltipSetItem", OnTooltipSetItem)
ShoppingTooltip1:SetScript("OnTooltipSetItem", OnTooltipSetItem)
ShoppingTooltip2:SetScript("OnTooltipSetItem", OnTooltipSetItem)
