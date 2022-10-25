-------------------------------------------------------------------------------
-- Premade Applicants Filter
-------------------------------------------------------------------------------
-- Copyright (C) 2022 Elotheon-Arthas-EU
--
-- This program is free software: you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the Free
-- Software Foundation, version 3.
--
-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details.
--
-- You should have received a copy of the GNU General Public License along with
-- this program. If not, see <https://www.gnu.org/licenses/>.
-------------------------------------------------------------------------------

local PAF = select(2, ...)
local L = PAF.L
local C = PAF.C

if GetLocale() ~= "ruRU" then return end

L["error.syntax"] = "|cffff0000Синтаксическая ошибка в выражении фильтра|r\n\nЭто означает, что Ваше выражение фильтра построено неправильно, например, не хватает парантезы или Вы написали 'tanks=1' вместо 'tanks==1'.\n\nПодробное сообщение об ошибке:\n|cffaaaaaa%s|r"
L["error.semantic"] = "|cffff0000Семантическая ошибка в выражении фильтра|r\n\nЭто означает, что Ваше выражение фильтра имеет правильный синтаксис, но Вы, скорее всего, неправильно написали имя переменной, например, 'tansk' вместо 'tanks'.\n\nПодробное сообщение об ошибке:\n|cffaaaaaa%s|r"

L["dialog.usepaf.tooltip"] = "Включить или отключить Premade Applicants Filter"
L["dialog.explanation"] = "Введите выражение фильтра, чтобы показать только подходящих кандидатов:"
L["dialog.tooltip.title"] = "Выражения фильтра"
L["dialog.tooltip.examples"] = "Примеры"
L["dialog.tooltip.quantifier"] = "Квантификатор"
L["dialog.tooltip.all"] = "все участники должны соответствовать предикату"
L["dialog.tooltip.some"] = "по крайней мере один участник должен соответствовать предикату"
L["dialog.tooltip.none"] = "то же самое, что и не все()"
L["dialog.tooltip.variable"] = "Переменная (неопределенная)"
L["dialog.tooltip.variable.quantified"] = "Переменная (количественно)"
L["dialog.tooltip.variable.rio"] = "Переменная (количественно, требуется Raider.IO)"
L["dialog.tooltip.description"] = "Описание"
L["dialog.tooltip.more"] = "... и многое другое, все ключевые слова см. на веб-сайте"
L["dialog.tooltip.members"] = "количество кандидатов в группе"
L["dialog.tooltip.level"] = "уровень кандидата"
L["dialog.tooltip.ilvl"] = "макс. уровень PvE предмета"
L["dialog.tooltip.pvplvl"] = "макс. уровень PvP предмета"
L["dialog.tooltip.hlvl"] = "уровень чести"
L["dialog.tooltip.friend"] = "если кандидат из Вашего списка друзей"
L["dialog.tooltip.guild"] = "если кандидат из Вашей гильдии"
L["dialog.tooltip.tank"] = "если кандидат может играть танком"
L["dialog.tooltip.heal"] = "если кандидат может играть целителем"
L["dialog.tooltip.dps"] = "если кандидат может наносить урон"
L["dialog.tooltip.range"] = "если класс кандидата может быть дальним боем"
L["dialog.tooltip.melee"] = "если класс кандидата может быть ближним боем"
L["dialog.tooltip.pvprating"] = "общий PvP-рейтинг кандидата в текущих реалиях"
L["dialog.tooltip.mprating"] = "общий рейтинг подземелий кандидата"
L["dialog.tooltip.mpmaprating"] = "рейтинг кандидата в этом подземелье"
L["dialog.tooltip.mpmapmaxkey"] = "макс. кандидата в этом подземелье"
L["dialog.tooltip.mpmapintime"] = "кандидат выполнил максимальное количество ключей вовремя"
L["dialog.tooltip.hasrio"] = "если кандидат имеет / не имеет рейтинга Rio"
L["dialog.tooltip.rio"] = "рейтинг Rio кандидата"
L["dialog.tooltip.riomain"] = "рейтинг Rio главного персонажа"
L["dialog.tooltip.rioprev"] = "рейтинг Rio (последний сезон)"
L["dialog.tooltip.riokey10plus"] = "количество завершенных +10 ключей или выше"
L["dialog.tooltip.rioheroicprogress"] = "героик боссы убиты в текущем рейде"
