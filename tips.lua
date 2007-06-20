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
local select = select
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor

local origs = {}
local tips = {"GameTooltip", "ItemRefTooltip", "ShoppingTooltip1", "ShoppingTooltip2"}

--[[
--	Za Warudo!
--]]
local OnTooltipSetItem = function(self, ...)
	local orig = origs[self]
	if(orig) then orig(self, ...) end

	local name, item = self:GetItem()
	if(item) then
		local quality = select(3, GetItemInfo(item))
		local r, g, b = GetItemQualityColor(quality)

		self:SetBackdropBorderColor(r, g, b)
		self:SetBackdropColor(0, 0, 0, 1)
	end
end

for _, v in ipairs(tips) do
	local obj = _G[v]

	origs[obj] = obj:GetScript"OnTooltipSetItem"
	obj:SetScript("OnTooltipSetItem", OnTooltipSetItem)
end