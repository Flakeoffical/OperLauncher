

getgenv().HasRunnedDropCMD = true



getgenv().DropCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                getgenv().MUF_sendChatMessage('Started Dropping!')    

                getgenv().CA_Dropping = true

                local LF_Loop

                local LF_loopFunction = function(amount)

                    game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', tostring(amount))

                end;

                local LF_Start = function(amount)

                    LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                        LF_loopFunction(amount)

                    end)

                end;

                local LF_Pause = function()

                    LF_Loop:Disconnect()

                    if getgenv().CA_DroppingUntil == true then

                        getgenv().CA_DroppingUntil = false

                        getgenv().CA_DropUntilAmount = 0

                    end

                    if game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000 then

                        getgenv().MUF_sendChatMessage("I don't have enough money, must have atleast 10K")

                    end

                    getgenv().MUF_sendChatMessage('Stopped Auto Drop')

                end;

            

                LF_Start(10000)

                repeat wait() until getgenv().CA_Dropping == false or getgenv().CA_DroppingUntil == true or game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000

                LF_Pause()

            end

        end

    else

        MUF_sendChatMessage('Started Dropping!')

        getgenv().CA_Dropping = true

        local LF_Loop

        local LF_loopFunction = function(amount)

            game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', tostring(amount))

        end;

        local LF_Start = function(amount)

            LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                LF_loopFunction(amount)

            end)

        end;

        local LF_Pause = function()

            LF_Loop:Disconnect()

            if getgenv().CA_DroppingUntil == true then

                getgenv().CA_DroppingUntil = false

                getgenv().CA_DropUntilAmount = 0

            end

            if game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000 then

                getgenv().MUF_sendChatMessage("I don't have enough money, must have atleast 10K")

            end

            getgenv().MUF_sendChatMessage('Stopped Auto Drop')

        end;

    

        LF_Start(10000)

        repeat wait() until getgenv().CA_Dropping == false or getgenv().CA_DroppingUntil == true or game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000

        LF_Pause()

    end

end

getgenv().HasRunnedStopCMD = true



getgenv().StopCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                getgenv().CA_DroppingUntil = false

                getgenv().CA_DropUntilDroppedAmount = 0

                getgenv().CA_DropUntilAmount = 0

                getgenv().CA_Dropping = false

                getgenv().MUF_sendChatMessage('Stopped All Dropping Types!')

            end

        else

            getgenv().MUF_sendChatMessage('unknown alt')

        end

    else

        getgenv().CA_DroppingUntil = false

        getgenv().CA_DropUntilDroppedAmount = 0

        getgenv().CA_DropUntilAmount = 0

        getgenv().CA_Dropping = false

        getgenv().MUF_sendChatMessage('Stopped All Dropping Types!')

    end

end

getgenv().HasRunnedDropUntilCMD = true



getgenv().DropUntilCMD = function(args)

    if getgenv().CA_DroppingUntil == false then

        getgenv().GF_StartDropUntil = function()

            for i=1, 10000000000000 do

                if getgenv().CA_DroppingUntil == false or getgenv().CA_Dropping == true or getgenv().CA_DropUntilDroppedAmount >= getgenv().CA_DropUntilAmount then

                    if getgenv().CA_Dropping == true then

                        getgenv().CA_DroppingUntil = false

                        getgenv().CA_Dropping = false

                    end

                    getgenv().CA_DroppingUntil = false

                    getgenv().CA_DropUntilAmount = 0

                    getgenv().CA_DropUntilDroppedAmount = 0

                    break

                end

                getgenv().CA_DropUntilDroppedAmount = getgenv().CA_DropUntilDroppedAmount + 7000

                game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', '10000')

                wait(15)

            end

        end

        if args[2] then

            if string.match(args[2], 'K') and not string.match(args[2], 'M') and not string.match(args[2], 'm') or string.match(args[2], 'k') and not string.match(args[2], 'M') and not string.match(args[2], 'm') or string.match(args[2], 'm') and not string.match(args[2], 'K') and not string.match(args[2], 'k') or string.match(args[2], 'M') and not string.match(args[2], 'K') and not string.match(args[2], 'k') then

                if string.match(args[2], 'K') and not string.match(args[2], 'M') and not string.match(args[2], 'm') then

                    -- K

                    local formatted = string.gsub(args[2], 'K', '', 1)

                    if tonumber(formatted) then

                        getgenv().CA_DropUntilDroppedAmount = 0

                        getgenv().CA_DroppingUntil = true

                        local thenew = string.gsub(args[2], 'K', '000')

                        if args[3] then

                            if tonumber(args[3]) then

                                if tonumber(args[3]) <= 38 and tonumber(args[3]) > 0 then

                                    getgenv().CA_DropUntilAmount = tonumber(thenew)/tonumber(args[3])

                                    getgenv().MUF_sendChatMessage('Started Dropping Until '..getgenv().MUF_updateText(tonumber(thenew))..'!')

                                    getgenv().GF_StartDropUntil()

                                else

                                    getgenv().MUF_sendChatMessage("Can't be more than 38 alts or lower than 1")

                                end

                            else

                                print('argument 3 must be number up to 38 alts')

                            end

                        else

                            getgenv().CA_DropUntilAmount = tonumber(thenew)

                            getgenv().MUF_sendChatMessage('Started Dropping Until '..getgenv().MUF_updateText(tonumber(thenew))..'!')

                            getgenv().GF_StartDropUntil()

                        end

                    else

                        getgenv().MUF_sendChatMessage('use numbers then K or M')

                    end

                elseif string.match(args[2], 'k') and not string.match(args[2], 'M') and not string.match(args[2], 'm') then

                    -- k

                    local formatted = string.gsub(args[2], 'k', '', 1)

                    if tonumber(formatted) then

                        getgenv().CA_DropUntilDroppedAmount = 0

                        getgenv().CA_DroppingUntil = true

                        local thenew = string.gsub(args[2], 'k', '000')

                        if args[3] then

                            if tonumber(args[3]) then

                                if tonumber(args[3]) <= 38 and tonumber(args[3]) > 0 then

                                    getgenv().CA_DropUntilAmount = tonumber(thenew)/tonumber(args[3])

                                    getgenv().MUF_sendChatMessage('Started Dropping Until '..getgenv().MUF_updateText(tonumber(thenew))..'!')

                                    getgenv().GF_StartDropUntil()

                                else

                                    getgenv().MUF_sendChatMessage("Can't be more than 38 alts or lower than 1")

                                end

                            else

                                print('argument 3 must be number up to 38 alts')

                            end

                        else

                            getgenv().CA_DropUntilAmount = tonumber(thenew)

                            getgenv().MUF_sendChatMessage('Started Dropping Until '..getgenv().MUF_updateText(tonumber(thenew))..'!')

                            getgenv().GF_StartDropUntil()

                        end

                    else

                        getgenv().MUF_sendChatMessage('use numbers then K or M')

                    end

                elseif string.match(args[2], 'M') and not string.match(args[2], 'K') and not string.match(args[2], 'k') then

                    -- M

                    local formatted = string.gsub(args[2], 'M', '', 1)

                    if tonumber(formatted) then

                        getgenv().CA_DropUntilDroppedAmount = 0

                        getgenv().CA_DroppingUntil = true

                        local thenew = string.gsub(args[2], 'M', '000000')

                        if args[3] then

                            if tonumber(args[3]) then

                                if tonumber(args[3]) <= 38 and tonumber(args[3]) > 0 then

                                    getgenv().CA_DropUntilAmount = tonumber(thenew)/tonumber(args[3])

                                    getgenv().MUF_sendChatMessage('Started Dropping Until '..getgenv().MUF_updateText(tonumber(thenew))..'!')

                                    getgenv().GF_StartDropUntil()

                                else

                                    getgenv().MUF_sendChatMessage("Can't be more than 38 alts or lower than 1")

                                end

                            else

                                print('argument 3 must be number up to 38 alts')

                            end

                        else

                            getgenv().CA_DropUntilAmount = tonumber(thenew)

                            getgenv().MUF_sendChatMessage('Started Dropping Until '..getgenv().MUF_updateText(tonumber(thenew))..'!')

                            getgenv().GF_StartDropUntil()

                        end

                    else

                        getgenv().MUF_sendChatMessage('use numbers then K or M')

                    end

                elseif string.match(args[2], 'm') and not string.match(args[2], 'K') and not string.match(args[2], 'k') then

                    -- m

                    local formatted = string.gsub(args[2], 'm', '', 1)

                    if tonumber(formatted) then

                        getgenv().CA_DropUntilDroppedAmount = 0

                        getgenv().CA_DroppingUntil = true

                        local thenew = string.gsub(args[2], 'm', '000000')

                        if args[3] then

                            if tonumber(args[3]) then

                                if tonumber(args[3]) <= 38 and tonumber(args[3]) > 0 then

                                    getgenv().CA_DropUntilAmount = tonumber(thenew)/tonumber(args[3])

                                    getgenv().MUF_sendChatMessage('Started Dropping Until '..getgenv().MUF_updateText(tonumber(thenew))..'!')

                                    getgenv().GF_StartDropUntil()

                                else

                                    getgenv().MUF_sendChatMessage("Can't be more than 38 alts or lower than 1")

                                end

                            else

                                print('argument 3 must be number up to 38 alts')

                            end

                        else

                            getgenv().CA_DropUntilAmount = tonumber(thenew)

                            getgenv().MUF_sendChatMessage('Started Dropping Until '..getgenv().MUF_updateText(tonumber(thenew))..'!')

                            getgenv().GF_StartDropUntil()

                        end

                    else

                        getgenv().MUF_sendChatMessage('use numbers then K or M')

                    end

                else

                    getgenv().MUF_sendChatMessage('Use K or M only after amount (2)')

                end

            else

                getgenv().MUF_sendChatMessage('Use K or M only after amount')

            end

        else

            getgenv().MUF_sendChatMessage('provide how much to drop with K or M')

        end

    else

        getgenv().CA_DroppingUntil = false

        getgenv().CA_DropUntilAmount = 0

        getgenv().MUF_sendChatMessage('Stopped Drop Until | $'..getgenv().MUF_updateText(getgenv().CA_DropUntilDroppedAmount)..' Dropped Yet!')

        getgenv().CA_DropUntilDroppedAmount = 0

    end

end

getgenv().HasRunnedBringCMD = true





getgenv().BringCMD = function(args)

    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = game:GetService("Players"):FindFirstChild(game:GetService("Players"):GetNameFromUserIdAsync(tonumber(getgenv().controller))).Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(4, 0, 0)

            end

        else

            getgenv().MUF_sendChatMessage('Unknown alt')

        end

    else

        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = game:GetService("Players"):FindFirstChild(game:GetService("Players"):GetNameFromUserIdAsync(tonumber(getgenv().controller))).Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(4, 0, 0)

    end

end

getgenv().HasRunnedSetupCMD = true



getgenv().SetupCMD = function(args)

    if args[2] then

        if args[2]:lower() == 'bank' then

            getgenv().LGF_TeleportAltsToBank = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-391.28, 21.47, -339.90)

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-383.29, 21.47, -340.17)

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-373.30, 21.47, -340.27)

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-364.55, 21.47, -339.91)

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-357.42, 21.47, -339.57)

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-391.72, 21.47, -330.29)

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-384.14, 21.47, -329.72)

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-376.74, 21.47, -329.23)

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-368.96, 21.47, -328.89)

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-357.75, 21.47, -328.77)

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-391.41, 21.47, -320.83)

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-383.24, 21.47, -320.56)

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-374.50, 21.47, -320.36)

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-366.63, 21.47, -320.08)

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-357.28, 21.47, -319.69)

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-392.12, 21.47, -314.77)

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-382.59, 21.47, -314.46)

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-375.08, 21.47, -314.32)

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-366.51, 21.47, -314.33)

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-357.26, 21.47, -314.34)

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-391.79, 21.47, -306.36)

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-383.13, 21.47, -305.72)

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-376.17, 21.47, -305.72)

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-366.60, 21.47, -305.74)

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-356.97, 21.47, -305.65)

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-391.82, 21.47, -297.73)

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-384.21, 21.47, -297.12)

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-375.70, 21.47, -296.77)

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-365.36, 21.47, -296.49)

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-356.83, 21.47, -295.41)

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-391.72, 21.47, -285.29)

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-383.71, 21.47, -284.95)

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-376.02, 21.47, -284.64)

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-365.46, 21.47, -283.57)

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-356.78, 21.47, -283.06)

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-383.89, 21.47, -273.47)

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-375.95, 21.47, -273.37)

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-366.85, 21.47, 272.94)

                end

            end

            getgenv().LGF_TeleportAltsToBank()

        elseif args[2]:lower() == 'admin' then

            getgenv().LGF_TeleportAltsToAdminBase = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-894.8657836914062, -39.401187896728516, -553.9047241210938) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-895.1825561523438, -39.401187896728516, -567.8170776367188) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-895.1011352539062, -38.901187896728516, -580.698974609375) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-895.02099609375, -38.901187896728516, -593.3446044921875) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-894.9393310546875, -39.10118865966797, -606.1416015625) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-880.18701171875, -38.40118408203125, -554.1747436523438) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-880.10009765625, -38.40118408203125, -567.90576171875) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-880.017333984375, -38.40118408203125, -580.9703369140625) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-879.9363403320312, -38.40118408203125, -593.6342163085938) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-880.517822265625, -38.40118408203125, -607.0358276367188) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.4531860351562, -38.401187896728516, -554.8992919921875) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.2959594726562, -38.401187896728516, -567.2496948242188) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.4403076171875, -38.401187896728516, -580.424560546875) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.5025024414062, -38.401187896728516, -594.418212890625) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.2288208007812, -38.401187896728516, -607.0742797851562) -- 15

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-850.0700073242188, -39.401187896728516, -555.0064086914062) -- 16

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-850.3143310546875, -39.401187896728516, -567.9920043945312) -- 17

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-850.1458129882812, -38.901187896728516, -581.055419921875) -- 18

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-850.1414794921875, -38.901187896728516, -593.385498046875) -- 19

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-850.2012939453125, -39.20118713378906, -606.4415893554688) -- 20

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-910.5515747070312, -39.401187896728516, -556.05615234375) -- 21

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-910.5818481445312, -39.401187896728516, -568.9136352539062) -- 22

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-910.4556274414062, -38.901187896728516, -582.5003662109375) -- 23

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-909.4376831054688, -38.901187896728516, -594.9976806640625) -- 24

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-910.2506103515625, -39.20118713378906, -606.5593872070312) -- 25

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-832.2540283203125, -39.401187896728516, -555.3170776367188) -- 26

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-832.2061157226562, -39.401187896728516, -568.3141479492188) -- 27

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-832.3546752929688, -38.901187896728516, -581.8248291015625) -- 28

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-832.4812622070312, -38.901187896728516, -593.3547973632812) -- 29

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-832.4165649414062, -39.20118713378906, -606.3519287109375) -- 30

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-831.1634521484375, -39.401187896728516, -620.0548095703125) -- 31

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-849.4916381835938, -39.401187896728516, -619.0955810546875) -- 32

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-864.494384765625, -38.401187896728516, -618.0387573242188) -- 33

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-880.2246704101562, -38.401187896728516, -618.1248168945312) -- 34

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-894.1553955078125, -39.401187896728516, -618.201171875) -- 35

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-910.26953125, -39.163795471191406, -618.8297729492188) -- 36

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-872.030029296875, -38.401187896728516, -585.260009765625) -- 37

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-872.5477294921875, -38.401187896728516, -629.4262084960938) -- 38

                end

            end

            getgenv().LGF_TeleportAltsToAdminBase()

        elseif args[2]:lower() == 'school' then

            getgenv().LGF_TeleportAltsToSchool = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-667.28, 21.57, 200.55)

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-667.14, 21.57, 195.61)

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-667.50, 21.54, 190.11)

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-667.44, 21.54, 185.01)

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-667.03, 21.57, 179.96)

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-651.46, 21.54, 180.03)

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-651.006, 21.57, 185.26)

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-651.08, 21.57, 190.44)

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-651.16, 21.59, 195.66)

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-651.23, 21.57, 200.25)

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-635.14, 21.57, 200.33)

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-635.19, 21.59, 194.75)

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-635.22, 21.57, 190.63)

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-635.27, 21.57, 185.34)

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-635.19, 21.59, 180.07)

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-619.30, 21.57, 180.26)

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-619.37, 21.57, 185.89)

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-619.37, 21.57, 185.89)

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-619.35, 21.57, 194.72)

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-619.39, 21.57, 200.39)

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-603.34, 21.57, 200.41)

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-603.30, 21.57, 194.64)

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-603.28, 21.57, 190.98)

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-603.31, 21.57, 185.86)

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-603.36, 21.57, 180.40)

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-587.23, 21.57, 180.33)

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-587.31, 21.57, 185.28)

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-587.27, 21.57, 190.66)

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-587.31, 21.57, 195.06)

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-587.35, 21.57, 200.38)

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-571.18, 21.59, 200.28)

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-571.24, 21.57, 194.75)

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-571.23, 21.57, 190.57)

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-571.19, 21.59, 184.82)

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-571.18, 21.59, 180.05)

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-554.87, 21.54, 179.98)

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-555.30, 21.57, 190.88)

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-554.97, 21.57, 200.51)

                end

            end

            getgenv().LGF_TeleportAltsToSchool()

        elseif args[2]:lower() == 'train' then

            getgenv().LGF_TeleportAltsToTrain = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(682.56, 54.22, -37.60) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(689.49, 54.22, -45.47) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(675.29, 54.22, -31.27) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(670.96, 50.92, -31.29) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(680.15, 51.22, -40.24) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(689.46, 50.92, -49.59) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(689.51, 48.22, -53.97) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(677.69, 48.22, -42.003) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(667.49, 48.52, -31.30) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(652.60, 48.22, -31.30) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(657.12, 48.22, -41.79) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(663.90, 48.22, -48.21) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(670.72, 48.22, -54.84) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(678.75, 48.22, 58.40) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(689.43, 48.22, -53.23) -- 15

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(689.43, 48.22, -72.98) -- 16

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(678.20, 48.22, -72.46) -- 17

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(668.98, 48.22, -71.50) -- 18

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(667.57, 48.22, -63.16) -- 19

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(663.90, 48.22, -55.58) -- 20

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(657.65, 48.22, -51.38) -- 21

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(649.95, 48.22, -49.65) -- 22

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(646.94, 48.22, -41.11) -- 23

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(646.19, 48.22, -31.61) -- 24

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(585.20, 48.22, -31.04) -- 25

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(689.41, 48.22, -104.16) -- 26

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(676.95, 48.22, -104.59) -- 27

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(663.93, 48.22, -104.17) -- 28

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(654.50, 48.22, -104.35) -- 29

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(645.42, 48.22, -104.60) -- 30

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(601.35, 48.22, -80.73) -- 31

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(601.30, 48.22, -70.28) -- 32

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(600.14, 48.22, -57.46) -- 33

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(600.02, 48.22, -48.76) -- 34

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(599.85, 48.22, -40.82) -- 35

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(599.68, 48.22, -31.60) -- 36

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(560.86, 34.72, -109.40) -- 37

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(599.76, 34.72, -147.70) -- 38

                end

            end

            getgenv().LGF_TeleportAltsToTrain()

        elseif args[2]:lower() == 'sz3' then

            getgenv().LGF_TeleportAltsToSafeZone3 = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.99, 11.97, 140.87) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.83, 11.97, 149.44) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.91, 11.97, 155.38) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.63, 11.97, 161.93) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.92, 11.97, 170.36) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.92, 11.97, 179.78) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.92, 11.97, 188.84) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.92, 11.97, 196.79) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.90, 11.97, 202.49) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.86, 11.97, 207.80) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(110.61, 11.97, 140.79) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(104.001, 11.97, 140.75) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(97.45, 11.97, 140.74) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(91.25, 11.97, 140.77) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(83.17, 11.97, 140.83) -- 15

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(43.24, 11.97, 229.46) -- 16

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(1.03, 11.97, 227.0008) -- 17

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(5.14, 11.97, 183.36) -- 18

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(58.89, 11.97, 187.58) -- 19

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(59.38, 11.97, 231.52) -- 20

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(22.82, 11.97, 173.35) -- 21

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(2.19, 11.97, 166.10) -- 22

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(20.32, 11.97, 138.25) -- 23

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-73.72, 11.97, 158.55) -- 24

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-47.009, 11.97, 221.87) -- 25

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-39.94, 11.97, 291.63) -- 26

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(61.19, 11.46, 314.27) -- 27

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(149.73, 11.97, 278.57) -- 28

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(161.85, 11.97, 227.36) -- 29

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(188.18, 11.97, 255.59) -- 30

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(183.31, 11.97, 323.88) -- 31

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-18.65, 11.46, 309.80) -- 32

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-67.12, 11.46, 309.08) -- 33

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-93.52, 11.97, 182.95) -- 34

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-112.14, 11.97, 147.14) -- 35

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-81.84, 11.97, 118.44) -- 36

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-52.58, 11.97, 142.57) -- 37

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(1.64, 11.97, 180.62) -- 38

                end

            end

            getgenv().LGF_TeleportAltsToSafeZone3()

        elseif args[2]:lower() == 'basket' then

            getgenv().LGF_TeleportAltsToBasket = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-994.48, 22.22, -482.50) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-963.27, 22.22, -482.23) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-969.70, 22.22, -482.20) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-974.50, 22.22, -493.81) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-980.78, 22.22, -493.28) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-986.61, 22.22, -493.32) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-993.15, 22.22, -491.21) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-993.40, 22.22, -473.13) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-986.64, 22.22, -471.45) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-980.88, 22.22, -471.29) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-974.70, 22.22, -471.20) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-947.43, 22.22, -480.84) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-916.27, 22.22, -482.99) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-931.92, 22.32, -499.14) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-932.08, 22.32, -466.60) -- 15

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-901.07, 22.22, -482.40) -- 16

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-895.41, 22.22, -482.17) -- 17

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-881.51, 22.22, -481.50) -- 18

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-870.54, 22.22, -481.74) -- 19

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-870.80, 22.22, -491.50) -- 20

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-877.98, 22.22, -493.72) -- 21

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-883.66, 22.22, -493.51) -- 22

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-889.99, 22.24, -493.18) -- 23

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(890.13, 22.22, -470.95) -- 24

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-883.04, 22.22, -470.82) -- 25

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-877.11, 22.22, -470.65) -- 26

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-877.11, 22.22, -470.65) -- 27

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-916.20, 22.22, -447.37) -- 28

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-918.20, 22.22, -510.33) -- 29

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-946.74, 22.22, -512.40) -- 30

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-995.52, 22.22, -442.49) -- 31

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-998.19, 22.22, -522.27) -- 32

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-932.65, 22.30, -517.69) -- 33

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-916.16, 22.22, -469.66) -- 34

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-916.23, 22.22, -491.62) -- 35

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-942.91, 22.22, -491.94) -- 36

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-943.32, 22.22, -469.68) -- 37

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-918.70, 22.22, -527.38) -- 38

                end

            end

            getgenv().LGF_TeleportAltsToBasket()

        elseif args[2]:lower() == 'taco' then

            getgenv().LGF_TeleportAltsToTacoShop = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(503.8083190917969, 48.25498962402344, -587.053466796875) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(503.7886962890625, 47.75498962402344, -579.1676025390625) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(503.68572998046875, 47.75498962402344, -571.37060546875) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(503.62548828125, 47.75498962402344, -565.5831909179688) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(503.4499816894531, 47.75498962402344, -558.89794921875) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(503.28167724609375, 47.75498962402344, -552.487548828125) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(506.59326171875, 48.2499885559082, -550.990478515625) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(512.0355834960938, 48.243621826171875, -551.0362548828125) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(517.7601318359375, 48.236480712890625, -550.96484375) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(523.5612182617188, 48.220787048339844, -550.878662109375) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(530.76025390625, 48.13629150390625, -550.52099609375) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(537.3292236328125, 48.17863464355469, -550.6953125) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(543.8451538085938, 48.23771286010742, -550.9771118164062) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(551.0494384765625, 48.217254638671875, -550.8612670898438) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(560.3720092773438, 48.1821403503418, -550.7071533203125) -- 15

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(568.7127075195312, 48.1568717956543, -550.609375) -- 16

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(576.4111328125, 48.13755416870117, -550.5252075195312) -- 17

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(576.324462890625, 47.75498962402344, -556.4823608398438) -- 18

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(576.8931884765625, 47.864906311035156, -562.1771240234375) -- 19

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(576.9207763671875, 47.864906311035156, -566.76904296875) -- 20

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(577.0294799804688, 47.864906311035156, -573.403076171875) -- 21

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(577.880126953125, 47.864906311035156, -580.0341186523438) -- 22

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(578.1847534179688, 47.864906311035156, -582.9446411132812) -- 23

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(578.4891967773438, 48.154991149902344, -587.8359985351562) -- 24

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(571.4197998046875, 48.154991149902344, -587.8607788085938) -- 25

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(564.643798828125, 48.154991149902344, -587.962158203125) -- 26

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(557.6697387695312, 48.154991149902344, -587.9202880859375) -- 27

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(550.6521606445312, 48.154991149902344, -587.88427734375) -- 28

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(543.4424438476562, 48.154991149902344, -587.9168701171875) -- 29

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(535.1602172851562, 48.154991149902344, -587.9348754882812) -- 30

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(528.3248291015625, 48.1049919128418, -588.0411987304688) -- 31

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(522.1769409179688, 48.1049919128418, -588.0496826171875) -- 32

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(518.077880859375, 48.20499038696289, -587.7919921875) -- 33

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(510.9388122558594, 48.20499038696289, -587.7742919921875) -- 34

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(503.7898254394531, 48.154991149902344, -587.8549194335938) -- 35

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(528.8453369140625, 47.75498962402344, -572.5838623046875) -- 36

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(560.9296264648438, 47.75498962402344, -572.4683227539062) -- 37

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(590.3792724609375, 47.864906311035156, -572.654541015625) -- 38

                end

            end

            getgenv().LGF_TeleportAltsToTacoShop()

        elseif args[2]:lower() == 'jail' then

            getgenv().LGF_TeleportAltsToAdminJail = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-819.4548950195312, -38.399200439453125, -850.262451171875) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-819.2421875, -38.39921188354492, -847.6025390625) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-819.3045654296875, -38.39921188354492, -843.946044921875) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-819.4843139648438, -38.39921188354492, -841.9553833007812) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-819.4802856445312, -38.39921188354492, -839.4085693359375) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-819.4896850585938, -38.39921188354492, -836.4739990234375) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-819.4794921875, -38.39921188354492, -834.5904541015625) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-819.4878540039062, -38.39921569824219, -832.4932250976562) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-819.2456665039062, -38.399208068847656, -829.292236328125) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-819.4878540039062, -38.39921188354492, -827.7582397460938) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-817.0413818359375, -38.39921188354492, -827.7025756835938) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-815.1101684570312, -38.39921188354492, -827.935546875) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-813.7570190429688, -38.39921188354492, -827.9363403320312) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-810.7586669921875, -38.39921188354492, -827.8728637695312) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-808.2550659179688, -38.39921188354492, -827.863525390625) -- 15

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-804.9404296875, -38.39921188354492, -827.7398071289062) -- 16

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-802.6648559570312, -38.39921188354492, -827.7599487304688) -- 17

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-799.373291015625, -38.39921188354492, -827.7357177734375) -- 18

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-795.6666259765625, -38.39921188354492, -827.7133178710938) -- 19

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-792.9666137695312, -37.99921417236328, -827.5033569335938) -- 20

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-789.4048461914062, -37.99921417236328, -827.5582275390625) -- 21

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-786.5997924804688, -38.39921188354492, -827.7686767578125) -- 22

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-783.6419677734375, -38.39921188354492, -827.7781372070312) -- 23

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-781.2205810546875, -38.39921188354492, -827.7872314453125) -- 24

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-779.8946533203125, -38.39921188354492, -828.0673828125) -- 25

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-777.7761840820312, -38.39921188354492, -827.911865234375) -- 26

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-777.5613403320312, -38.399208068847656, -830.2344970703125) -- 27

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-777.5448608398438, -38.39920425415039, -833.6351318359375) -- 28

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-777.6680297851562, -38.399208068847656, -835.6477661132812) -- 29

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-777.7586669921875, -38.39921188354492, -838.6112670898438) -- 30

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-777.7935791015625, -38.39921188354492, -842.275390625) -- 31

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-777.7908935546875, -38.39921188354492, -844.6223754882812) -- 32

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-777.793701171875, -38.39921188354492, -846.8689575195312) -- 33

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-777.7872924804688, -38.39921188354492, -848.3513793945312) -- 34

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-777.77783203125, -38.399208068847656, -850.0695190429688) -- 35

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-798.9217529296875, -39.64921188354492, -838.8948364257812) -- 36

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-812.3771362304688, -39.64921188354492, -838.7993774414062) -- 37

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-786.1926879882812, -39.64921188354492, -838.3900146484375) -- 38

                end

            end

            getgenv().LGF_TeleportAltsToAdminJail()

        elseif args[2]:lower() == 'undertrain' then

            getgenv().LGF_TeleportAltsToUnderTrain = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(684.7232055664062, 34.49801254272461, -148.7730255126953) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(674.7918090820312, 34.49801254272461, -148.78802490234375) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(662.3942260742188, 34.49801254272461, -149.0093994140625) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(650.6766967773438, 34.49801254272461, -149.218505859375) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(639.6124877929688, 34.49801254272461, -149.41607666015625) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(620.384765625, 34.49801254272461, -149.7593994140625) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(606.7877807617188, 34.49801254272461, -150.002197265625) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(595.2987060546875, 34.49801254272461, -146.18624877929688) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(585.1758422851562, 34.49801254272461, -136.5103759765625) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(573.9328002929688, 34.49801254272461, -125.58360290527344) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(565.8177490234375, 34.49801254272461, -117.61354064941406) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(559.5093994140625, 34.49801254272461, -102.19771575927734) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(559.3411254882812, 34.49801254272461, -89.79932403564453) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(559.1935424804688, 34.49801254272461, -78.26739501953125) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(559.0779418945312, 34.49801254272461, -69.26850128173828) -- 15

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(559.7725219726562, 34.49801254272461, -56.35504913330078) -- 16

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(684.7232055664062, 54.49801254272461, -148.7730255126953) -- 17

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(674.7918090820312, 54.49801254272461, -148.78802490234375) -- 18

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(662.3942260742188, 54.49801254272461, -149.0093994140625) -- 19

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(650.6766967773438, 54.49801254272461, -149.218505859375) -- 20

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(639.6124877929688, 54.49801254272461, -149.41607666015625) -- 21

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(620.384765625, 54.49801254272461, -149.7593994140625) -- 22

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(606.7877807617188, 54.49801254272461, -150.002197265625) -- 23

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(595.2987060546875, 54.49801254272461, -146.18624877929688) -- 24

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(585.1758422851562, 54.49801254272461, -136.5103759765625) -- 25

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(573.9328002929688, 54.49801254272461, -125.58360290527344) -- 26

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(565.8177490234375, 54.49801254272461, -117.61354064941406) -- 27

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(559.5093994140625, 54.49801254272461, -102.19771575927734) -- 28

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(559.3411254882812, 54.49801254272461, -89.79932403564453) -- 29

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(559.1935424804688, 54.49801254272461, -78.26739501953125) -- 30

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(559.0779418945312, 54.49801254272461, -69.26850128173828) -- 31

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(559.7725219726562, 54.49801254272461, -56.35504913330078) -- 32

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(684.7232055664062, 74.49801254272461, -148.7730255126953) -- 33

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(674.7918090820312, 74.49801254272461, -148.78802490234375) -- 34

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(662.3942260742188, 74.49801254272461, -149.0093994140625) -- 35

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(650.6766967773438, 74.49801254272461, -149.218505859375) -- 36

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(639.6124877929688, 74.49801254272461, -149.41607666015625) -- 37

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(620.384765625, 74.49801254272461, -149.7593994140625) -- 38

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true

                end

            end

            getgenv().LGF_TeleportAltsToUnderTrain()

        elseif args[2]:lower() == 'bank' then

            getgenv().LGF_TeleportAltsToClub = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-285.3577575683594, -6.208345890045166, -398.874267578125) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-273.8269958496094, -6.208345890045166, -398.75811767578125) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-264.77850341796875, -6.208345890045166, -398.19110107421875) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-253.04779052734375, -6.208345890045166, -397.997802734375) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-242.8048095703125, -6.208345890045166, -397.84765625) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-241.70343017578125, -6.208347320556641, -390.20660400390625) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-254.7361602783203, -6.208347320556641, -391.1738586425781) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-262.60089111328125, -6.208347320556641, -390.95654296875) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-273.0194396972656, -6.208347320556641, -390.53857421875) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-284.1500549316406, -6.208347320556641, -390.3243713378906) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-284.0184631347656, -6.208347320556641, -382.1261901855469) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-274.1438293457031, -6.208347320556641, -381.0790710449219) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-264.0174865722656, -6.208347320556641, -380.70574951171875) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-253.62904357910156, -6.208347320556641, -380.4176025390625) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-243.1863250732422, -6.208347320556641, -379.7025451660156) -- 15

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-243.48544311523438, -6.208347320556641, -370.3070068359375) -- 16

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-252.0637664794922, -6.208347320556641, -370.9783630371094) -- 17

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-262.4604187011719, -6.208347320556641, -371.2687072753906) -- 18

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-272.8909912109375, -6.208347320556641, -371.80401611328125) -- 19

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-284.892333984375, -6.208347320556641, -371.78265380859375) -- 20

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-285.029541015625, -6.208347320556641, -362.71795654296875) -- 21

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-272.930419921875, -6.208347320556641, -361.8711242675781) -- 22

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-263.0042419433594, -6.208347320556641, -361.530517578125) -- 23

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-252.88803100585938, -6.208347320556641, -360.93206787109375) -- 24

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-241.75489807128906, -6.208347320556641, -360.8272399902344) -- 25

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-242.5441131591797, -6.208347320556641, -352.8920593261719) -- 26

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-252.81076049804688, -6.208347320556641, -352.98687744140625) -- 27

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-262.32086181640625, -6.208347320556641, -353.5709533691406) -- 28

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-272.77789306640625, -6.208347320556641, -353.9857177734375) -- 29

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-285.3577575683594, -6.208347320556641, -354.6908264160156) -- 30

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-274.4442138671875, -6.208347320556641, -348.8157043457031) -- 31

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-265.67230224609375, -6.208347320556641, -348.2086486816406) -- 32

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-254.34959411621094, -6.208347320556641, -347.85382080078125) -- 33

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-241.15333557128906, -6.208347320556641, -347.5159606933594) -- 34

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-280.4551696777344, 0.03133717179298401, -340.1517028808594) -- 35

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-273.459716796875, 0.03133717179298401, -339.91448974609375) -- 36

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-250.1305694580078, 0.03133717179298401, -340.2205810546875) -- 37

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-257.3221435546875, 0.03133717179298401, -340.25341796875) -- 38

                end

            end

            getgenv().LGF_TeleportAltsToClub()

        elseif getgenv().MUF_ReturnClosestPlayer(args[2]) then

            local choosenplrpos = getgenv().MUF_ReturnClosestPlayer(args[2]).Character:FindFirstChild('HumanoidRootPart').Position

            plr.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(choosenplrpos.X - math.random(1,25), choosenplrpos.Y, choosenplrpos.Z - math.random(1,25))

        end

    else

        local controllerpos = getgenv().PlayersService:FindFirstChild(getgenv().PlayersService:GetNameFromUserIdAsync(tonumber(getgenv().controller))).Character:FindFirstChild('HumanoidRootPart').Position

        plr.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(controllerpos.X - math.random(1,25), controllerpos.Y, controllerpos.Z - math.random(1,25))

    end

end

getgenv().HasRunnedCrashCMD = true



getgenv().CrashCMD = function(args)

    setfpscap(200)

    if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] or game.Players.LocalPlayer.UserId == getgenv().controller then

        if args[2] then

            if args[2]:lower() == 'swag' then

                if args[3] then

                    if tonumber(args[3]) then

                        local thefinal = tonumber(args[3])

                        for k = 1, thefinal do

                            loadstring(game:HttpGet('https://raw.githubusercontent.com/lerkermer/lua-projects/master/SuperCustomServerCrasher'))()

                        end

                        if args[4] then

                            if tonumber(args[4]) then

                                setfpscap(tonumber(args[4]))

                            end

                        end

                    else

                        getgenv().MUF_sendChatMessage('the argument 2 must be number(s) not string')

                    end

                else

                    loadstring(game:HttpGet('https://raw.githubusercontent.com/lerkermer/lua-projects/master/SuperCustomServerCrasher'))()

                    getgenv().MUF_sendChatMessage('Loaded Swag On Alt1 & Controller!!')

                end

            elseif args[2]:lower() == 'encrypt' then

                if args[3] then

                    if tonumber(args[3]) then

                        local thefinal = tonumber(args[3])

                        for k = 1, thefinal do

                            loadstring(game:HttpGet("https://raw.githubusercontent.com/LPrandom/lua-projects/master/encryptgui.lua"))()

                        end

                        if args[4] then

                            if tonumber(args[4]) then

                                setfpscap(tonumber(args[4]))

                            end

                        end

                    else

                        getgenv().MUF_sendChatMessage('the argument 2 must be number(s) not string')

                    end

                else

                    loadstring(game:HttpGet("https://raw.githubusercontent.com/LPrandom/lua-projects/master/encryptgui.lua"))()

                    getgenv().MUF_sendChatMessage('Loaded Encrypt On Alt1 & Controller!')

                end

            end

        else

            loadstring(game:HttpGet('https://raw.githubusercontent.com/lerkermer/lua-projects/master/SuperCustomServerCrasher'))()

            getgenv().MUF_sendChatMessage('Loaded Swag On Alt1 & Controller!!')

        end

    end

end

getgenv().HasRunnedKickAltsCMD = true



getgenv().KickAltsCMD = function(args)

    if args[2] then

        game.Players.LocalPlayer:Kick('Controller Kicked Alts, Reason: '..string.gsub(CommandText, 'kickalts ', "", string.len('kickalts') + 1))

    else

        game.Players.LocalPlayer:Kick('Controller Kicked Alts, Reason: unknown')

    end

end

getgenv().HasRunnedFreezeCMD = true



getgenv().FreezeCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if getgenv().CA_IsFreezing == true then

                    getgenv().CA_IsFreezing = false

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                    getgenv().MUF_sendChatMessage('Unfreezed!')

                else

                    getgenv().CA_IsFreezing = true

                    if getgenv().CA_IsAirlocking == true then

                        getgenv().CA_IsAirlocking = false

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                    end

                    if getgenv().CA_IsGraving == true then

                        getgenv().CA_IsGraving = false

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                    end

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

                    getgenv().MUF_sendChatMessage('Freezed!')

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        if getgenv().CA_IsFreezing == true then

            getgenv().CA_IsFreezing = false

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            getgenv().MUF_sendChatMessage('Unfreezed!')

        else

            getgenv().CA_IsFreezing = true

            if getgenv().CA_IsAirlocking == true then

                getgenv().CA_IsAirlocking = false

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            end

            if getgenv().CA_IsGraving == true then

                getgenv().CA_IsGraving = false

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            end

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

            getgenv().MUF_sendChatMessage('Freezed!')

        end

    end

end

getgenv().HasRunnedWalletCMD = true



getgenv().WalletCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if game.Players.LocalPlayer.Character:FindFirstChild('Wallet') then

                    game.Players.LocalPlayer.Character:FindFirstChild('Wallet').Parent = game.Players.LocalPlayer.Backpack

                elseif game.Players.LocalPlayer.Backpack:FindFirstChild('Wallet') then

                    game.Players.LocalPlayer.Backpack:FindFirstChild('Wallet').Parent = game.Players.LocalPlayer.Character

                else

                    getgenv().MUF_sendChatMessage('I can not find wallet')

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        if game.Players.LocalPlayer.Character:FindFirstChild('Wallet') then

            game.Players.LocalPlayer.Character:FindFirstChild('Wallet').Parent = game.Players.LocalPlayer.Backpack

        elseif game.Players.LocalPlayer.Backpack:FindFirstChild('Wallet') then

            game.Players.LocalPlayer.Backpack:FindFirstChild('Wallet').Parent = game.Players.LocalPlayer.Character

        else

            getgenv().MUF_sendChatMessage('I can not find wallet')

        end

    end

end

getgenv().HasRunnedAirlockCMD = true



getgenv().AirlockCMD = function(args)

    if args[2] then

        if args[2]:lower() == 'all' then

            if getgenv().CA_IsAirlocking == true then

                getgenv().CA_IsAirlocking = false

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                getgenv().MUF_sendChatMessage('Unairlocked!')

            else

                getgenv().CA_IsAirlocking = true

                if getgenv().CA_IsFreezing == true then

                    getgenv().CA_IsFreezing = false

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                end

                if getgenv().CA_IsGraving == true then

                    getgenv().CA_IsGraving = false

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                end

                if args[3] then

                    if tonumber(args[3]) then

                        local plrpos = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(plrpos.X, plrpos.Y + tonumber(args[3]), plrpos.Z)

                        wait(0.02)

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

                        getgenv().MUF_sendChatMessage('Airlocked!')

                    else

                        getgenv().MUF_sendChatMessage('Argument 3 must be number')

                    end

                else

                    local plrpos = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(plrpos.X, plrpos.Y + 15, plrpos.Z)

                    wait(0.02)

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

                    getgenv().MUF_sendChatMessage('Airlocked!')

                end

            end

        elseif getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if getgenv().CA_IsAirlocking == true then

                    getgenv().CA_IsAirlocking = false

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                    getgenv().MUF_sendChatMessage('Unairlocked!')

                else

                    getgenv().CA_IsAirlocking = true

                    if getgenv().CA_IsFreezing == true then

                        getgenv().CA_IsFreezing = false

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                    end

                    if getgenv().CA_IsGraving == true then

                        getgenv().CA_IsGraving = false

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                    end

                    if args[3] then

                        if tonumber(args[3]) then

                            local plrpos = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

                            game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(plrpos.X, plrpos.Y + tonumber(args[3]), plrpos.Z)

                            wait(0.02)

                            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

                            getgenv().MUF_sendChatMessage('Airlocked!')

                        else

                            getgenv().MUF_sendChatMessage('Argument 3 must be number')

                        end

                    else

                        local plrpos = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(plrpos.X, plrpos.Y + 15, plrpos.Z)

                        wait(0.02)

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

                        getgenv().MUF_sendChatMessage('Airlocked!')

                    end

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        if getgenv().CA_IsAirlocking == true then

            getgenv().CA_IsAirlocking = false

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            getgenv().MUF_sendChatMessage('Unairlocked!')

        else

            getgenv().CA_IsAirlocking = true

            if getgenv().CA_IsFreezing == true then

                getgenv().CA_IsFreezing = false

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            end

            if getgenv().CA_IsGraving == true then

                getgenv().CA_IsGraving = false

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            end

            local plrpos = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

            game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(plrpos.X, plrpos.Y + 15, plrpos.Z)

            wait(0.02)

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

            getgenv().MUF_sendChatMessage('Airlocked!')

        end

    end

end

getgenv().HasRunnedResetCMD = true



getgenv().ResetCMD = function(args)

    if args[2] then

        if getgev().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                game.Players.LocalPlayer.Character:FindFirstChild('Humanoid').Health = 0

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

        game.Players.LocalPlayer.Character:FindFirstChild('Humanoid').Health = 0

    end

end

getgenv().HasRunnedSayCMD = true



getgenv().SayCMD = function(CommandText)

    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(string.gsub(CommandText, 'say ', "", string.len('say') + 1), "All")

end

getgenv().HasRunnedSetAdTimeCMD = true



getgenv().SetAdTimeCMD = function(args)

    if args[2] then

        if tonumber(args[2]) then

            getgenv().sendadevery = tonumber(args[2])

            getgenv().MUF_sendChatMessage('Changed ad sending time to '..getgenv().sendadevery..' second!')

        end

    end

end

getgenv().HasRunnedAdvertCMD = true



getgenv().AdvertCMD = function(args)

    if getgenv().CA_AdvertsingMessage == nil then return getgenv().MUF_sendChatMessage('you need to use setad [message] then this command!') end

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if getgenv().CA_Advertsing == false then

                    getgenv().MUF_sendChatMessage('Started Sending Ad Message every '..getgenv().sendadevery..' seconds!')

                    getgenv().CA_Advertsing = true

                    getgenv().GF_StartAdvertising = function()

                        for i=1, 100000000000 do

                            if getgenv().CA_Advertsing == false then

                                break

                            end

                            wait(tonumber(getgenv().sendadevery))

                            getgenv().MUF_sendChatMessage(getgenv().CA_AdvertsingMessage)

                        end

                    end

                    getgenv().GF_StartAdvertising()

                else

                    getgenv().CA_Advertsing = false

                    getgenv().MUF_sendChatMessage('Stopped Sending Ad Message!')

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        if getgenv().CA_Advertsing == false then

            getgenv().GF_StartAdvertising = function()

                for i=1, 100000000000 do

                    if getgenv().CA_Advertsing == false then

                        break

                    end

                    wait(tonumber(getgenv().sendadevery))

                    getgenv().MUF_sendChatMessage(getgenv().CA_AdvertsingMessage)

                end

            end

            getgenv().MUF_sendChatMessage('Started Sending Ad Message every '..getgenv().sendadevery..' seconds!')

            getgenv().CA_Advertsing = true

            getgenv().GF_StartAdvertising()

        else

            getgenv().CA_Advertsing = false

            getgenv().MUF_sendChatMessage('Stopped Sending Ad Message!')

        end

    end

end

getgenv().HasRunnedFpsCMD = true



getgenv().FpsCMD = function(args)

    if args[2] then

        if tonumber(args[2]) then

            getgenv().CA_MaxFPS = tonumber(args[2])

            setfpscap(getgenv().CA_MaxFPS)

            getgenv().MUF_sendChatMessage('Running on '..getgenv().CA_MaxFPS..' fps!')

        end

    end

end

getgenv().HasRunnedCashAuraCMD = true



getgenv().CashAuraCMD = function(args)

    if args[2] then

        getgenv().GF_PickUpUntil = function()

            for i=1, 10000000000000 do

                if getgenv().PickingUp == false or getgenv().PickedUpPickedAmount >= getgenv().CA_PickupUntilAmount then

                    getgenv().PickingUp = false

                    getgenv().CA_PickupUntilAmount = 0

                    getgenv().CA_PickupUntilPickedAmount = 0

                    break

                end

                for i, thechild in pairs(game.Workspace:WaitForChild('Ignored'):WaitForChild('Drop'):GetChildren()) do

                    if thechild.Name == 'MoneyDrop' or thechild.Name == 'MoneyDropCounted' then

                        if game.Players.LocalPlayer:DistanceFromCharacter(thechild.Position) < 13 then

                            local function CalculateD(s)

                                local data = string.match(s, '%d[%d.,]*')

                                local numdata = string.gsub(data, ",", "")

                                return tonumber(numdata)

                            end

                            local cal = CalculateD(thechild.BillboardGui.TextLabel.Text)

                            getgenv().CA_PickupUntilPickedAmount = tonumber(cal)

                            fireclickdetector(thechild:FindFirstChild('ClickDetector'), 12)

                        end

                    end

                end

                wait(0.1)

            end

        end

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if getgenv().CA_AutoCashPickup == false then

                    if args[3] then

                        if tonumber(args[3]) then

                            if string.match(args[3], 'K') and not string.match(args[3], 'M') and not string.match(args[3], 'm') or string.match(args[3], 'k') and not string.match(args[2], 'M') and not string.match(args[3], 'm') or string.match(args[3], 'm') and not string.match(args[3], 'K') and not string.match(args[3], 'k') or string.match(args[3], 'M') and not string.match(args[3], 'K') and not string.match(args[3], 'k') then

                                if string.match(args[3], 'K') and not string.match(args[3], 'M') and not string.match(args[3], 'm') then

                                    -- K

                                    local formatted = string.gsub(args[3], 'K', '', 1)

                                    if tonumber(formatted) then

                                        getgenv().CA_PickupUntilPickedAmount = 0

                                        PickingUp = true

                                        local thenew = string.gsub(args[3], 'K', '000')

                                        getgenv().CA_PickupUntilAmount = tonumber(thenew)

                                        getgenv().MUF_sendChatMessage('Started Picking Up Until '..getgenv().MUF_updateText(tonumber(thenew))..'!')

                                        getgenv().GF_PickUpUntil()

                                    else

                                        getgenv().MUF_sendChatMessage('use numbers then K or M')

                                    end

                                elseif string.match(args[3], 'k') and not string.match(args[3], 'M') and not string.match(args[3], 'm') then

                                    -- k

                                    local formatted = string.gsub(args[3], 'k', '', 1)

                                    if tonumber(formatted) then

                                        getgenv().CA_PickupUntilPickedAmount = 0

                                        getgenv().PickingUp = true

                                        local thenew = string.gsub(args[3], 'k', '000')

                                        getgenv().CA_PickupUntilAmount = tonumber(thenew)

                                        getgenv().MUF_sendChatMessage('Started Picking Up Until '..getgenv().MUF_updateText(tonumber(thenew))..'!')

                                        getgenv().GF_PickUpUntil()

                                    else

                                        getgenv().MUF_sendChatMessage('use numbers then K or M')

                                    end

                                elseif string.match(args[2], 'M') and not string.match(args[3], 'K') and not string.match(args[3], 'k') then

                                    -- M

                                    local formatted = string.gsub(args[3], 'M', '', 1)

                                    if tonumber(formatted) then

                                        getgenv().CA_PickupUntilPickedAmount = 0

                                        getgenv().PickingUp = true

                                        local thenew = string.gsub(args[3], 'M', '000000')

                                        getgenv().CA_DropUntilAmount = tonumber(thenew)

                                        getgenv().MUF_sendChatMessage('Started Picking Up Until '..getgenv().MUF_updateText(tonumber(thenew))..'!')

                                        getgenv().GF_PickUpUntil()

                                    else

                                        getgenv().MUF_sendChatMessage('use numbers then K or M')

                                    end

                                elseif string.match(args[3], 'm') and not string.match(args[3], 'K') and not string.match(args[3], 'k') then

                                    -- m

                                    local formatted = string.gsub(args[3], 'm', '', 1)

                                    if tonumber(formatted) then

                                        getgenv().CA_PickupUntilPickedAmount = 0

                                        getgenv().PickingUp = true

                                        local thenew = string.gsub(args[3], 'm', '000000')

                                        getgenv().CA_PickupUntilAmount = tonumber(thenew)

                                        getgenv().MUF_sendChatMessage('Started Picking Up Until '..getgenv().MUF_updateText(tonumber(thenew))..'!')

                                        getgenv().GF_PickUpUntil()

                                    else

                                        getgenv().MUF_sendChatMessage('use numbers then K or M')

                                    end

                                else

                                    getgenv().MUF_sendChatMessage('Use K or M only after amount (2)')

                                end

                            else

                                getgenv().MUF_sendChatMessage('Use K or M only after amount')

                            end

                        end

                    else

                        getgenv().CA_AutoCashPickup = true

                        getgenv().MUF_sendChatMessage('Started picking up cash with '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                        local LF_Loop

                        local LF_loopFunction = function()

                            for i, thechild in pairs(game.Workspace:WaitForChild('Ignored'):WaitForChild('Drop'):GetChildren()) do

                                if thechild.Name == 'MoneyDrop' or thechild.Name == 'MoneyDropCounted' then

                                    if game.Players.LocalPlayer:DistanceFromCharacter(thechild.Position) < 13 then

                                        fireclickdetector(thechild:FindFirstChild('ClickDetector'), 12)

                                    end

                                end

                            end

                        end;

                        local LF_Start = function()

                            LF_Loop = RunService.Heartbeat:Connect(LF_loopFunction);

                        end;

                        local LF_Pause = function()

                            LF_Loop:Disconnect()

                            getgenv().MUF_sendChatMessage('Stopped Cashaura')

                        end;

                    

                        LF_Start()

                        repeat wait() until getgenv().CA_AutoCashPickup == false

                        LF_Pause()

                    end

                elseif getgenv().CA_AutoCashPickup == true then

                    getgenv().CA_AutoCashPickup = false

                    getgenv().MUF_sendChatMessage(getgenv().MUF_ReturnClosestPlayer(args[2])..' No longer picking up cash!')

                elseif getgenv().PickingUp == true then

                    getgenv().PickingUp = false

                    getgenv().MUF_sendChatMessage('Stopped picking up until')

                end

            end

        end

    else

        if getgenv().CA_AutoCashPickup == false then

            getgenv().CA_AutoCashPickup = true

            getgenv().MUF_sendChatMessage('Started picking up cash!')

            local LF_Loop

            local LF_loopFunction = function()

                for i, thechild in pairs(game.Workspace:WaitForChild('Ignored'):WaitForChild('Drop'):GetChildren()) do

                    if thechild.Name == 'MoneyDrop' or thechild.Name == 'MoneyDropCounted' then

                        if game.Players.LocalPlayer:DistanceFromCharacter(thechild.Position) < 13 then

                            fireclickdetector(thechild:FindFirstChild('ClickDetector'), 12)

                        end

                    end

                end

            end;

            local LF_Start = function()

                LF_Loop = RunService.Heartbeat:Connect(LF_loopFunction);

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                getgenv().MUF_sendChatMessage('Stopped Cashaura')

            end;

        

            LF_Start()

            repeat wait() until getgenv().CA_AutoCashPickup == false

            LF_Pause()

        elseif getgenv().CA_AutoCashPickup == true then

            getgenv().CA_AutoCashPickup = false

            getgenv().MUF_sendChatMessage('Stopped picking up cash!')

        elseif getgenv().PickingUp == true then

            getgenv().PickingUp = false

            getgenv().MUF_sendChatMessage('Stopped picking up until!')

        end

    end

end

getgenv().HasRunnedVibeCMD = true



getgenv().VibeCMD = function(args)

    if args[2] then

        if args[2]:lower() == 'all' then

            if args[3] then

                if tonumber(args[3]) then

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false



                    local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                    local animation = Instance.new("Animation")

                    animation.AnimationId = "http://www.roblox.com/asset/?id="..args[3]

                    local animationTrack = humanoid:LoadAnimation(animation)

                    animationTrack:Play()

                    getgenv().MUF_sendChatMessage('Vibing Custom Dance!')

                else

                    getgenv().MUF_sendChatMessage('Argument 3 must be a number of id')

                end

            else

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false



                local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                local animation = Instance.new("Animation")

                animation.AnimationId = "http://www.roblox.com/asset/?id=3189776546"

                local animationTrack = humanoid:LoadAnimation(animation)

                animationTrack:Play()

                getgenv().MUF_sendChatMessage('Vibing!')

            end

        elseif getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if args[3] then

                if tonumber(args[3]) then

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false



                    local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                    local animation = Instance.new("Animation")

                    animation.AnimationId = "http://www.roblox.com/asset/?id="..args[3]

                    local animationTrack = humanoid:LoadAnimation(animation)

                    animationTrack:Play()

                    getgenv().MUF_sendChatMessage('Vibing Custom Dance!')

                else

                    getgenv().MUF_sendChatMessage('Argument 3 must be a number of id')

                end

            else

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false



                local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                local animation = Instance.new("Animation")

                animation.AnimationId = "http://www.roblox.com/asset/?id=3189776546"

                local animationTrack = humanoid:LoadAnimation(animation)

                animationTrack:Play()

                getgenv().MUF_sendChatMessage('Vibing!')

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false



        local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

        local animation = Instance.new("Animation")

        animation.AnimationId = "http://www.roblox.com/asset/?id=3189776546"

        local animationTrack = humanoid:LoadAnimation(animation)

        animationTrack:Play()

        getgenv().MUF_sendChatMessage('Vibing!')

    end

end

getgenv().HasRunnedFollowCMD = true



getgenv().FollowCMD = function(args)

    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().CA_FollowingUser == false then

                getgenv().CA_FollowingUser = true

                getgenv().MUF_sendChatMessage('Started Following '..getgenv().MUF_ReturnClosestName(args[2]).Name..'!')

                if args[2] then

                    if tonumber(args[3]) then

                        local LF_Loop

                        local LF_loopFunction = function(theuser, thespeed)

                            local followingpos = theuser.Character:FindFirstChild('HumanoidRootPart').Position

                            plr.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(followingpos.X - math.random(1,25), followingpos.Y, followingpos.Z - math.random(1,25))

                            wait(thespeed)

                        end;

                        local LF_Start = function(theuser, thespeed)

                            LF_Loop = RunService.Heartbeat:Connect(function()

                                LF_loopFunction(theuser, thespeed)

                            end)

                        end;

                        local LF_Pause = function()

                            LF_Loop:Disconnect()

                            getgenv().MUF_sendChatMessage('Stopped Following')

                        end;

                    

                        LF_Start(getgenv().MUF_ReturnClosestPlayer(args[2], tonumber(args[3])))

                        repeat wait() until getgenv().CA_FollowingUser == false

                        LF_Pause()

                    else

                        local LF_Loop

                        local LF_loopFunction = function(theuser, thespeed)

                            local followingpos = theuser.Character:FindFirstChild('HumanoidRootPart').Position

                            plr.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(followingpos.X - math.random(1,25), followingpos.Y, followingpos.Z - math.random(1,25))

                            wait(thespeed)

                        end;

                        local LF_Start = function(theuser, thespeed)

                            LF_Loop = RunService.Heartbeat:Connect(function(theuser, thespeed)

                                LF_loopFunction(theuser, thespeed)

                            end)

                        end;

                        local LF_Pause = function()

                            LF_Loop:Disconnect()

                            getgenv().MUF_sendChatMessage('Stopped Following')

                        end;

                    

                        LF_Start(getgenv().MUF_ReturnClosestPlayer(args[2]), 0.1)

                        repeat wait() until getgenv().CA_FollowingUser == false

                        LF_Pause()

                    end

                else

                    local LF_Loop

                    local LF_loopFunction = function(theuser, thespeed)

                        local followingpos = theuser.Character:FindFirstChild('HumanoidRootPart').Position

                        plr.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(followingpos.X - math.random(1,25), followingpos.Y, followingpos.Z - math.random(1,25))

                        wait(thespeed)

                    end;

                    local LF_Start = function(theuser, thespeed)

                        LF_Loop = RunService.Heartbeat:Connect(function()

                            LF_loopFunction(theuser, thespeed)

                        end)

                    end;

                    local LF_Pause = function()

                        LF_Loop:Disconnect()

                        MUF_sendChatMessage('Stopped Following')

                    end;

                

                    LF_Start(getgenv().MUF_ReturnClosestPlayer(args[2]), 0.1)

                    repeat wait() until getgenv().CA_FollowingUser == false

                    LF_Pause()

                end

            else

                getgenv().CA_FollowingUser = false

                getgenv().MUF_sendChatMessage('Stopped Following!')

            end

        end

    else

        if getgenv().CA_FollowingUser == false then

            getgenv().CA_FollowingUser = true

            if args[2] then

                if tonumber(args[2]) then

                    local LF_Loop

                    local LF_loopFunction = function(theuser, thespeed)

                        local followingpos = theuser.Character:FindFirstChild('HumanoidRootPart').Position

                        plr.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(followingpos.X - math.random(1,25), followingpos.Y, followingpos.Z - math.random(1,25))

                        wait(thespeed)

                    end;

                    local LF_Start = function(theuser, thespeed)

                        LF_Loop = RunService.Heartbeat:Connect(function(theuser, thespeed)

                            LF_loopFunction(theuser, thespeed)

                        end)

                    end;

                    local LF_Pause = function()

                        LF_Loop:Disconnect()

                        getgenv().MUF_sendChatMessage('Stopped Following')

                    end;

                

                    LF_Start(getgenv().PlayersService:FindFirstChild(getgenv().PlayersService:GetNameFromUserIdAsync(tonumber(getgenv().controller))), tonumber(args[2]))

                    repeat wait() until getgenv().CA_FollowingUser == false

                    LF_Pause()

                else

                    local LF_Loop

                    local LF_loopFunction = function(theuser, thespeed)

                        local followingpos = theuser.Character:FindFirstChild('HumanoidRootPart').Position

                        plr.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(followingpos.X - math.random(1,25), followingpos.Y, followingpos.Z - math.random(1,25))

                        wait(thespeed)

                    end;

                    local LF_Start = function(theuser, thespeed)

                        LF_Loop = RunService.Heartbeat:Connect(function()

                            LF_loopFunction(theuser, thespeed)

                        end)

                    end;

                    local LF_Pause = function()

                        LF_Loop:Disconnect()

                        getgenv().MUF_sendChatMessage('Stopped Following')

                    end;

                

                    LF_Start(getgenv().PlayersService:FindFirstChild(getgenv().PlayersService:GetNameFromUserIdAsync(tonumber(getgenv().controller))), 0.1)

                    repeat wait() until getgenv().CA_FollowingUser == false

                    LF_Pause()

                end

            else

                local LF_Loop

                local LF_loopFunction = function(theuser, thespeed)

                    local followingpos = theuser.Character:FindFirstChild('HumanoidRootPart').Position

                    plr.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(followingpos.X - math.random(1,25), followingpos.Y, followingpos.Z - math.random(1,25))

                    wait(thespeed)

                end;

                local LF_Start = function(theuser, thespeed)

                    LF_Loop = RunService.Heartbeat:Connect(function()

                        LF_loopFunction(theuser, thespeed)

                    end)

                end;

                local LF_Pause = function()

                    LF_Loop:Disconnect()

                    getgenv().MUF_sendChatMessage('Stopped Following')

                end;

            

                LF_Start(getgenv().PlayersService:FindFirstChild(getgenv().PlayersService:GetNameFromUserIdAsync(tonumber(getgenv().controller))), 0.1)

                repeat wait() until getgenv().CA_FollowingUser == false

                LF_Pause()

            end

        else

            getgenv().CA_FollowingUser = false

        end

    end

end

getgenv().HasRunnedHideCMD = true



getgenv().HideCMD = function()

    game.Players.LocalPlayer.UserId = getgenv().CA_RealId

    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-240.86, 93.37, 283.02)

    wait(5)

    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

end

getgenv().HasRunnedLoopDestroyCMD = true



getgenv().LoopDestroyCMD = function(args)

    if getgenv().CA_CashAutoDestroy == false then

        getgenv().CA_CashAutoDestroy = true

        getgenv().MUF_sendChatMessage('Started Destroying Cash Parts Here!')

        local LF_Loop

        local LF_loopFunction = function()

            for i, thepart in pairs(game.Workspace:WaitForChild('Ignored'):WaitForChild('Drop'):GetChildren()) do

                if thepart.Name == 'MoneyDrop' or thepart.Name == 'MoneyDropCounted' then

                    thepart:Destroy()

                end

            end

        end;

        local LF_Start = function()

            LF_Loop = RunService.Heartbeat:Connect(LF_loopFunction);

        end;

        local LF_Pause = function()

            LF_Loop:Disconnect()

            getgenv().MUF_sendChatMessage('Stopped Auto Cash Parts Destroy Here!')

        end;

    

        LF_Start()

        repeat wait() until getgenv().CA_CashAutoDestroy == false

        LF_Pause()

    else

        getgenv().CA_CashAutoDestroy = false

    end

end

getgenv().HasRunnedKillCMD = true



getgenv().KillCMD = function(args)

    if game.Players.LocalPlayer:FindFirstChild('Backpack'):FindFirstChild('Combat') then

        game.Players.LocalPlayer:FindFirstChild('Backpack'):FindFirstChild('Combat').Parent = game.Players.LocalPlayer.Character

    end

    if getgenv().CA_IsFreezing == true then

        getgenv().CA_IsFreezing = false

        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

    end

    if getgenv().CA_IsAirlocking == true then

        getgenv().CA_IsAirlocking = false

        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

    end

    if getgenv().CA_IsGraving == true then

        getgenv().CA_IsGraving = false

        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

    end

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if args[3] then

                if getgenv().MUF_ReturnClosestPlayer(args[3]) then

                    if getgenv().MUF_ReturnClosestPlayer(args[3]) == game.Players.LocalPlayer then

                        getgenv().MUF_sendChatMessage('Started Loop Killing '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                        getgenv().CA_IsAutoKilling = true

                        local LF_Loop

                        local LF_loopFunction = function(thetarget)

                            if game.Players.LocalPlayer:FindFirstChild('Backpack'):FindFirstChild('Combat') then

                                wait(0.5)

                                game.Players.LocalPlayer:FindFirstChild('Backpack'):FindFirstChild('Combat').Parent = game.Players.LocalPlayer.Character

                                wait(0.3)

                                LF_loopFunction(thetarget)

                            end

                            

                            if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script') and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script').Name ~= 'Health' then

                                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script'):Destroy()

                                LF_loopFunction(thetarget)

                            end

                    

                            if game.Players.LocalPlayer.Character:FindFirstChild('BodyEffects'):FindFirstChild('K.O').Value == true then

                                game.Players.LocalPlayer.Character:FindFirstChild('Humanoid').Health = 0

                            end

                            

                            game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = thetarget.Character:FindFirstChild('HumanoidRootPart').CFrame

                            game.Players.LocalPlayer.Character.Combat:Activate()

                            wait(0.05)

                        end;

                        local LF_Start = function(thetarget)

                            LF_Loop = RunService.Heartbeat:Connect(function()

                                LF_loopFunction(thetarget)

                            end)

                        end;

                        local LF_Pause = function()

                            LF_Loop:Disconnect()

                            getgenv().MUF_sendChatMessage('Successfully Stopped Loop Kill')

                        end;

                    

                        LF_Start(getgenv().MUF_ReturnClosestPlayer(args[2]))

                        repeat wait() until getgenv().CA_IsAutoKilling == false

                        LF_Pause()

                    end

                end

            else

                if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                    getgenv().MUF_sendChatMessage('Started Loop Killing '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                    getgenv().CA_IsAutoKilling = true

                    local LF_Loop

                    local LF_loopFunction = function(thetarget)

                        if game.Players.LocalPlayer:FindFirstChild('Backpack'):FindFirstChild('Combat') then

                            wait(0.5)

                            game.Players.LocalPlayer:FindFirstChild('Backpack'):FindFirstChild('Combat').Parent = game.Players.LocalPlayer.Character

                            wait(0.3)

                            LF_loopFunction(thetarget)

                        end

                        

                        if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script') and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script').Name ~= 'Health' then

                            game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script'):Destroy()

                            LF_loopFunction(thetarget)

                        end

                

                        if game.Players.LocalPlayer.Character:FindFirstChild('BodyEffects'):FindFirstChild('K.O').Value == true then

                            game.Players.LocalPlayer.Character:FindFirstChild('Humanoid').Health = 0

                        end

                        

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = thetarget.Character:FindFirstChild('HumanoidRootPart').CFrame

                        game.Players.LocalPlayer.Character.Combat:Activate()

                        wait(0.05)

                    end;

                    local LF_Start = function(thetarget)

                        LF_Loop = RunService.Heartbeat:Connect(function()

                            LF_loopFunction(thetarget)

                        end)

                    end;

                    local LF_Pause = function()

                        LF_Loop:Disconnect()

                        getgenv().MUF_sendChatMessage('Successfully Stopped Loop Kill')

                    end;

                

                    LF_Start(getgenv().MUF_ReturnClosestPlayer(args[2]))

                    repeat wait() until getgenv().CA_IsAutoKilling == false

                    LF_Pause()

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Player')

        end

    end

end

getgenv().HasRunnedStopKillCMD = true



getgenv().StopKillCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                getgenv().CA_IsAutoKilling = false

            end

        end

    else

        getgenv().CA_IsAutoKilling = false

    end

end

getgenv().HasRunnedLineCMD = true



getgenv().LineCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if getgenv().CA_IsFreezing == true then

                    getgenv().CA_IsFreezing = false

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                end

                if getgenv().CA_IsAirlocking == true then

                    getgenv().CA_IsAirlocking = false

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                end

                if getgenv().CA_IsGraving == true then

                    getgenv().CA_IsGraving = false

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                end

                getgenv().LGF_LineUpAlts = function(TheTarget)

                    if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(5, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt2'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(10, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt3'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(15, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt4'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(20, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt5'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(25, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt6'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(30, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt7'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(35, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt8'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(40, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt9'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(45, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt10'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(50, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt11'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(55, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt12'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(60, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt13'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(60, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt14'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(65, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt15'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(60, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt16'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(65, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt17'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(70, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt18'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(75, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt19'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(80, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt20'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(85, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt21'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(90, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt22'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(95, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt23'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(100, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt24'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(105, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt25'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(110, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt26'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(115, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt27'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(120, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt28'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(125, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt29'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(130, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt30'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(135, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt31'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(140, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt32'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(145, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt33'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(150, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt34'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(155, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt35'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(160, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt36'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(165, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt37'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(170, 0, 0)

                    elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt38'] then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(175, 0, 0)

                    end

                end

                getgenv().LGF_LineUpAlts(MUF_ReturnClosestPlayer(args[2]))

                getgenv().MUF_sendChatMessage('Lined up next to '..MUF_ReturnClosestName(args[2])..'!')

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        if getgenv().CA_IsFreezing == true then

            getgenv().CA_IsFreezing = false

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

        end

        if getgenv().CA_IsAirlocking == true then

            getgenv().CA_IsAirlocking = false

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

        end

        if getgenv().CA_IsGraving == true then

            getgenv().CA_IsGraving = false

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

        end

        getgenv().LGF_LineUpAlts = function(TheTarget)

            if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(5, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt2'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(10, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt3'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(15, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt4'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(20, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt5'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(25, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt6'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(30, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt7'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(35, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt8'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(40, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt9'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(45, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt10'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(50, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt11'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(55, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt12'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(60, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt13'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(60, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt14'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(65, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt15'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(60, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt16'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(65, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt17'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(70, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt18'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(75, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt19'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(80, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt20'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(85, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt21'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(90, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt22'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(95, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt23'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(100, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt24'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(105, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt25'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(110, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt26'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(115, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt27'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(120, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt28'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(125, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt29'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(130, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt30'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(135, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt31'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(140, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt32'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(145, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt33'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(150, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt34'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(155, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt35'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(160, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt36'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(165, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt37'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(170, 0, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt38'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(175, 0, 0)

            end

        end

        getgenv().LGF_LineUpAlts(getgenv().PlayersService:FindFirstChild(getgenv().PlayersService:GetNameFromUserIdAsync(tonumber(getgenv().controller))))

        getgenv().MUF_sendChatMessage('Lined up next to controller!')

    end

end

getgenv().HasRunnedBlockCMD = true



getgenv().BlockCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if game.Players.LocalPlayer.Character:FindFirstChild('BodyEffects'):FindFirstChild('Block') then

                    game.ReplicatedStorage.MainEvent:FireServer("Block", false)

                    getgenv().MUF_sendChatMessage('Stopped Blocking')

                else

                    game.ReplicatedStorage.MainEvent:FireServer("Block", true)

                    getgenv().MUF_sendChatMessage('Started Blocking')

                end

            end

        else

            getgenv().MUF_sendChatMessage('unknown alt')

        end

    else

        if game.Players.LocalPlayer.Character:FindFirstChild('BodyEffects'):FindFirstChild('Block') then

            game.ReplicatedStorage.MainEvent:FireServer("Block", false)

            getgenv().MUF_sendChatMessage('Stopped Blocking')

        else

            game.ReplicatedStorage.MainEvent:FireServer("Block", true)

            getgenv().MUF_sendChatMessage('Started Blocking')

        end

    end

end

getgenv().HasRunnedSpamCMD = true



getgenv().SpamCMD = function(args)

    if getgenv().CA_SpammingMessage == false then

        getgenv().CA_SpammingMessage = true

        local LF_Loop

        local LF_loopFunction = function(themsg)

            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(themsg, "All")

        end;

        local LF_Start = function(themsg)

            LF_Loop = RunService.Heartbeat:Connect(function()

                LF_loopFunction(themsg)

            end)

        end;

        local LF_Pause = function()

            LF_Loop:Disconnect()

            getgenv().MUF_sendChatMessage('Stopped Spamming')

        end;

    

        LF_Start(string.gsub(CommandText, 'spam ', "", string.len('spam') + 1))

        repeat wait() until getgenv().CA_SpammingMessage == false

        LF_Pause()

    else

        getgenv().CA_SpammingMessage = false

    end

end

getgenv().HasRunnedNoClipCMD = true



getgenv().NoClipCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if getgenv().CA_IsNoClipping == false then

                    getgenv().CA_IsNoClipping = true

                    for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do

                        if v:IsA("BasePart") and v.CanCollide == true and game.Players.LocalPlayer.Character:FindFirstChild('BodyEffects'):FindFirstChild("K.O").Value == false then

                           v.CanCollide = false

                           v:FindFirstChild('HumanoidRootPart').CanCollide = false

                        end

                     end

                else

                    getgenv().CA_IsNoClipping = false

                    for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do

                       if v:IsA("BasePart") and v.CanCollide == true and game.Players.LocalPlayer.Character:FindFirstChild('BodyEffects'):FindFirstChild("K.O").Value == false then

                          v.CanCollide = true

                          v:FindFirstChild('HumanoidRootPart').CanCollide = true

                       end

                    end

                end

                getgenv().MUF_sendChatMessage('Toggled NoClip!')

            end

        end

    else

        if getgenv().CA_IsNoClipping == false then

            getgenv().CA_IsNoClipping = true

            for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do

                if v:IsA("BasePart") and v.CanCollide == true and game.Players.LocalPlayer.Character:FindFirstChild('BodyEffects'):FindFirstChild("K.O").Value == false then

                   v.CanCollide = false

                   v:FindFirstChild('HumanoidRootPart').CanCollide = false

                end

             end

        else

            getgenv().CA_IsNoClipping = false

            for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do

               if v:IsA("BasePart") and v.CanCollide == true and game.Players.LocalPlayer.Character:FindFirstChild('BodyEffects'):FindFirstChild("K.O").Value == false then

                  v.CanCollide = true

                  v:FindFirstChild('HumanoidRootPart').CanCollide = true

               end

            end

        end

        getgenv().MUF_sendChatMessage('Toggled NoClip!')

    end

end

getgenv().HasRunnedMaskCMD = true



getgenv().MaskCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                local LastPosition = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

                if game.Players.LocalPlayer.Character:FindFirstChild('Mask') then

                    game.Players.LocalPlayer.Character:FindFirstChild('Mask'):Activate()

                    getgenv().MUF_sendChatMessage('Toggled Mask!')

                else

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(589.8815, 48.9980, -269.5245)

                    wait(0.5)

                    fireclickdetector(game:GetService('Workspace'):WaitForChild('Ignored'):WaitForChild('Shop'):WaitForChild('[Skull Mask] - $60'):WaitForChild('ClickDetector'), 9)

                    wait(0.6)

                    game.Players.LocalPlayer:WaitForChild('Backpack'):FindFirstChild('Mask').Parent = game.Players.LocalPlayer.Character

                    wait(0.3)

                    game.Players.LocalPlayer.Character:FindFirstChild('Mask'):Activate()

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(LastPosition.X, LastPosition.Y, LastPosition.Z)

                end

            end

        else

            getgenv().MUF_sendChatMessage('unknown alt')

        end

    else

        local LastPosition = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

        if game.Players.LocalPlayer.Character:FindFirstChild('Mask') then

            game.Players.LocalPlayer.Character:FindFirstChild('Mask'):Activate()

            getgenv().MUF_sendChatMessage('Toggled Mask!')

        else

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(589.8815, 48.9980, -269.5245)

            wait(0.5)

            fireclickdetector(game:GetService('Workspace'):WaitForChild('Ignored'):WaitForChild('Shop'):WaitForChild('[Skull Mask] - $60'):WaitForChild('ClickDetector'), 9)

            wait(0.6)

            game.Players.LocalPlayer:WaitForChild('Backpack'):WaitForChild('Mask').Parent = game.Players.LocalPlayer.Character

            wait(0.3)

            game.Players.LocalPlayer.Character:FindFirstChild('Mask'):Activate()

            game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(LastPosition.X, LastPosition.Y, LastPosition.Z)

        end

    end

end

getgenv().HasRunnedWeightFarmCMD = true



getgenv().WeightFarmCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if getgenv().CA_IsFarmingWeight == false then

                    getgenv().CA_IsFarmingWeight = true

                    getgenv().MUF_sendChatMessage('Started Farming Weight!')

                    local function TheWeight()

                        for i=1, 10000000000 do

                            if CA_IsFarmingWeight == false then

                                getgenv().MUF_sendChatMessage('Stopped Weight Auto Farm')

                                break

                            end

                            if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script') and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script').Name ~= 'Health' then

                                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script'):Destroy()

                                TheWeight()

                            end

                            if getgenv().CA_IsFreezing == true then

                                getgenv().CA_IsFreezing = false

                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                                TheWeight()

                            end

                            if getgenv().CA_IsAirlocking == true then

                                getgenv().CA_IsAirlocking = false

                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                                TheWeight()

                            end

                            if getgenv().CA_IsGraving == true then

                                getgenv().CA_IsGraving = false

                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                                TheWeight()

                            end

                            if not game.Players.LocalPlayer.Character:FindFirstChild('[HeavyWeights]') and getgenv().CA_IsFarmingWeight == true then

                                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-46.57, 22.94, -655.77)

                                wait(0.5)

                                fireclickdetector(game:GetService('Workspace'):WaitForChild('Ignored'):WaitForChild('Shop'):WaitForChild('[HeavyWeights] - $250'):WaitForChild('ClickDetector'), 7)

                                wait(0.4)

                                if game.Players.LocalPlayer:WaitForChild('Backpack'):FindFirstChild('[HeavyWeights]') then

                                    game.Players.LocalPlayer:WaitForChild('Backpack'):FindFirstChild('[HeavyWeights]').Parent = game.Players.LocalPlayer.Character

                                    TheWeight()

                                end

                            end

                            wait(0.4)

                            game.Players.LocalPlayer.Character:FindFirstChild('[HeavyWeights]'):Activate()

                            wait(0.2)

                        end

                    end

                    TheWeight()

                else

                    getgenv().CA_IsFarmingWeight = false

                end

            end

        else

            getgenv().MUF_sendChatMessage('unknown alt')

        end

    else

        if getgenv().CA_IsFarmingWeight == false then

            getgenv().CA_IsFarmingWeight = true

            getgenv().MUF_sendChatMessage('Started Farming Weight!')

            local function TheWeight()

                for i=1, 10000000000 do

                    if getgenv().CA_IsFarmingWeight == false then

                        getgenv().MUF_sendChatMessage('Stopped Weight Auto Farm')

                        break

                    end

                    if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script') and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script').Name ~= 'Health' then

                        game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script'):Destroy()

                        TheWeight()

                    end

                    if getgenv().CA_IsFreezing == true then

                        getgenv().CA_IsFreezing = false

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                        TheWeight()

                    end

                    if getgenv().CA_IsAirlocking == true then

                        getgenv().CA_IsAirlocking = false

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                        TheWeight()

                    end

                    if getgenv().CA_IsGraving == true then

                        getgenv().CA_IsGraving = false

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                        TheWeight()

                    end

                    if not game.Players.LocalPlayer.Character:FindFirstChild('[HeavyWeights]') and getgenv().CA_IsFarmingWeight == true then

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-46.57, 22.94, -655.77)

                        wait(0.5)

                        fireclickdetector(game:GetService('Workspace'):WaitForChild('Ignored'):WaitForChild('Shop'):WaitForChild('[HeavyWeights] - $250'):WaitForChild('ClickDetector'), 7)

                        wait(0.4)

                        if game.Players.LocalPlayer:WaitForChild('Backpack'):FindFirstChild('[HeavyWeights]') then

                            game.Players.LocalPlayer:WaitForChild('Backpack'):FindFirstChild('[HeavyWeights]').Parent = game.Players.LocalPlayer.Character

                            TheWeight()

                        end

                    end

                    wait(0.4)

                    game.Players.LocalPlayer.Character:FindFirstChild('[HeavyWeights]'):Activate()

                    wait(0.2)

                end

            end

            TheWeight()

        else

            getgenv().CA_IsFarmingWeight = false

        end

    end

end

getgenv().HasRunnedLettuceFarmCMD = true



getgenv().LettuceFarmCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if getgenv().CA_IsFarmingLettuce == false then

                    getgenv().CA_IsFarmingLettuce = true

                    getgenv().MUF_sendChatMessage('Started Farming Lettuce!')

                    local function TheLettuce()

                        for i=1, 100000000000 do

                            if CA_IsFarmingLettuce == false then

                                getgenv().MUF_sendChatMessage('Stopped Lettuce Auto Farm')

                                break

                            end

                            if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script') and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script').Name ~= 'Health' then

                                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script'):Destroy()

                                TheLettuce()

                            end

                            if getgenv().CA_IsFreezing == true then

                                getgenv().CA_IsFreezing = false

                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                                TheLettuce()

                            end

                            if getgenv().CA_IsAirlocking == true then

                                getgenv().CA_IsAirlocking = false

                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                                TheLettuce()

                            end

                            if getgenv().CA_IsGraving == true then

                                getgenv().CA_IsGraving = false

                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                                TheLettuce()

                            end

                            game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-84.31, 25.44, -632.59)

                            wait(0.5)

                            fireclickdetector(game:GetService('Workspace'):WaitForChild('Ignored'):WaitForChild('Shop'):WaitForChild('[Lettuce] - $5'):WaitForChild('ClickDetector'), 7)

                            wait(0.4)

                            if game.Players.LocalPlayer:WaitForChild('Backpack'):FindFirstChild('[Lettuce]') then

                                game.Players.LocalPlayer:WaitForChild('Backpack'):FindFirstChild('[Lettuce]').Parent = game.Players.LocalPlayer.Character

                                wait(0.2)

                                game.Players.LocalPlayer.Character:FindFirstChild('[Lettuce]'):Activate()

                            end

                            wait(0.2)

                        end

                    end

                    TheLettuce()

                else

                    getgenv().CA_IsFarmingLettuce = false

                end

            end

        else

            getgenv().MUF_sendChatMessage('unknown alt')

        end

    else

        if getgenv().CA_IsFarmingLettuce == false then

            getgenv().CA_IsFarmingLettuce = true

            getgenv().MUF_sendChatMessage('Started Farming Lettuce')

            local function TheLettuce()

                for i=1, 100000000000 do

                    if CA_IsFarmingLettuce == false then

                        getgenv().MUF_sendChatMessage('Stopped Lettuce Auto Farm')

                        break

                    end

                    if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script') and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script').Name ~= 'Health' then

                        game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script'):Destroy()

                        TheLettuce()

                    end

                    if getgenv().CA_IsFreezing == true then

                        getgenv().CA_IsFreezing = false

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                        TheLettuce()

                    end

                    if getgenv().CA_IsAirlocking == true then

                        getgenv().CA_IsAirlocking = false

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                        TheLettuce()

                    end

                    if getgenv().CA_IsGraving == true then

                        getgenv().CA_IsGraving = false

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                        TheLettuce()

                    end

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-84.31, 25.44, -632.59)

                    wait(0.5)

                    fireclickdetector(game:GetService('Workspace'):WaitForChild('Ignored'):WaitForChild('Shop'):WaitForChild('[Lettuce] - $5'):WaitForChild('ClickDetector'), 7)

                    wait(0.4)

                    if game.Players.LocalPlayer:WaitForChild('Backpack'):FindFirstChild('[Lettuce]') then

                        game.Players.LocalPlayer:WaitForChild('Backpack'):FindFirstChild('[Lettuce]').Parent = game.Players.LocalPlayer.Character

                        wait(0.2)

                        game.Players.LocalPlayer.Character:FindFirstChild('[Lettuce]'):Activate()

                    end

                    wait(0.2)

                end

            end

            TheLettuce()

        else

            getgenv().CA_IsFarmingLettuce = false

        end

    end

end

getgenv().HasRunnedGodCMD = true



getgenv().GodCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if game.Players.LocalPlayer.Character:FindFirstChild("BodyEffects"):FindFirstChild("Attacking") then

                    game.Players.LocalPlayer.Character:FindFirstChild("BodyEffects"):FindFirstChild("Attacking"):Destroy()

                    getgenv().MUF_sendChatMessage('God moded!')

                else

                    getgenv().MUF_sendChatMessage('Already god moded, to stop use reset command')

                end

            end

        else

            getgenv().MUF_sendChatMessage('unknown alt')

        end

    else

        if game.Players.LocalPlayer.Character:FindFirstChild("BodyEffects"):FindFirstChild("Attacking") then

            game.Players.LocalPlayer.Character:FindFirstChild("BodyEffects"):FindFirstChild("Attacking"):Destroy()

            getgenv().MUF_sendChatMessage('God moded!')

        else

            getgenv().MUF_sendChatMessage('Already god moded, to stop use reset command')

        end

    end

end

getgenv().HasRunnedFormCMD = true



getgenv().FormCMD = function(args)

    if args[2]:lower() == 'bank' then

        if args[3]:lower() == 'heart' then

            getgenv().LGF_FormHeartBank = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-375.98, 21.24, -311.05) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-380.84, 21.24, -307.47) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-384.01, 21.25, -301.39) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-379.03, 21.43, -296.81) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-369.56, 21.24, -296.11) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-374.87, 21.24, -299.45) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-366.18, 21.24, -300.31) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-368.07, 21.25, -305.38) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-371.25, 21.43, -308.65) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-369.56, 21.24, -296.11) -- 10

                end

            end

            getgenv().LGF_FormHeartBank()

        end

    elseif args[2]:lower() == 'train' then

        if args[3]:lower() == 'heart' then

            getgenv().LGF_FormHeartTrain = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(668.6963500976562, 47.99998474121094, -50.05579376220703) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(664.9501953125, 47.9999885559082, -51.303627014160156) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(661.9150390625, 47.9999885559082, -51.9164924621582) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(658.5404663085938, 47.9999885559082, -52.69816970825195) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(655.2764892578125, 47.9999885559082, -52.799163818359375) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(651.3389892578125, 47.9999885559082, -53.89844512939453) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(647.2667236328125, 47.9999885559082, -54.95363998413086) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(646.6383666992188, 47.9999885559082, -58.97539520263672) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(651.3568725585938, 47.9999885559082, -62.000946044921875) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(655.7596435546875, 47.9999885559082, -62.756988525390625) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(658.7531127929688, 47.9999885559082, -65.70852661132812) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(660.5314331054688, 47.9999885559082, -69.0993423461914) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(662.7195434570312, 47.9999885559082, -72.23925018310547) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(669.1116333007812, 47.9999885559082, -71.40550231933594) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(671.0115966796875, 47.9999885559082, -66.94071960449219) -- 15

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(671.8225708007812, 47.9999885559082, -61.4381217956543) -- 16

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(672.2294311523438, 47.9999885559082, -56.50005340576172) -- 17

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(673.21875, 47.9999885559082, -51.492191314697266) -- 18

                end

            end

            getgenv().LGF_FormHeartTrain()

        end

    elseif args[2]:lower() == 'admin' then

        if args[3]:lower() == 'heart' then

            getgenv().LGF_FormHeartAdmin = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-869.7515258789062, -38.39920425415039, -605.1906127929688) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-867.17041015625, -38.39920425415039, -602.4441528320312) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-864.3773193359375, -38.39920425415039, -599.4344482421875) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-861.7991333007812, -38.39920425415039, -596.5096435546875) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-859.606201171875, -38.39920425415039, -593.2157592773438) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-857.396484375, -38.39920425415039, -587.962890625) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-857.203125, -38.39920425415039, -582.2883911132812) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-862.2939453125, -38.39920425415039, -577.3399658203125) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.2889404296875, -38.39920425415039, -580.8877563476562) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-867.2338256835938, -38.39920425415039, -584.9208374023438) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-868.837890625, -38.39920425415039, -586.7218017578125) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-870.8543701171875, -38.39920425415039, -584.1116943359375) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-873.1826171875, -38.39920425415039, -580.9710083007812) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-876.4962158203125, -38.39920425415039, -579.1199951171875) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-880.7739868164062, -38.39920425415039, -580.3616333007812) -- 15

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-883.0680541992188, -38.39920425415039, -583.9224853515625) -- 16

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-882.1114501953125, -38.39920425415039, -588.7933959960938) -- 17

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-881.166015625, -38.39920425415039, -592.8011474609375) -- 18

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-878.17822265625, -38.39920425415039, -597.821044921875) -- 19

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-874.8457641601562, -38.39920425415039, -601.7138671875) -- 20

                end

            end

            getgenv().LGF_FormHeartAdmin()

        end

    end

end

getgenv().HasRunnedStackCMD = true



getgenv().StackCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().CA_IsFreezing == true then

                getgenv().CA_IsFreezing = false

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            end

            if getgenv().CA_IsAirlocking == true then

                getgenv().CA_IsAirlocking = false

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            end

            if getgenv().CA_IsGraving == true then

                getgenv().CA_IsGraving = false

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            end

            getgenv().LGF_StackLadderAlts = function(TheTarget)

                if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt2'] then

                    wait(0.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt1']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt3'] then

                    wait(0.2)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt2']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt4'] then

                    wait(0.3)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt3']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt5'] then

                    wait(0.4)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt4']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt6'] then

                    wait(0.5)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt5']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt7'] then

                    wait(0.6)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt6']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt8'] then

                    wait(0.7)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt7']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt9'] then

                    wait(0.8)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt8']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt10'] then

                    wait(0.9)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt9']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt11'] then

                    wait(1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt10']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt12'] then

                    wait(1.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt11']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt13'] then

                    wait(1.2)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt12']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt14'] then

                    wait(1.3)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt13']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt15'] then

                    wait(1.4)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt14']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt16'] then

                    wait(1.5)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt15']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt17'] then

                    wait(1.6)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt16']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt18'] then

                    wait(1.7)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt17']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt19'] then

                    wait(1.8)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt18']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt20'] then

                    wait(1.9)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt19']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt21'] then

                    wait(2)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt20']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt22'] then

                    wait(2.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt21']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt23'] then

                    wait(2.2)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt22']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt24'] then

                    wait(2.3)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt23']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt25'] then

                    wait(2.4)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt24']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt26'] then

                    wait(2.5)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt25']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt27'] then

                    wait(2.6)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt26']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt28'] then

                    wait(2.7)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt27']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt29'] then

                    wait(2.8)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt28']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt30'] then

                    wait(2.9)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt29']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt31'] then

                    wait(3)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt30']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt32'] then

                    wait(3.1)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt31']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt33'] then

                    wait(3.2)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt32']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt34'] then

                    wait(3.3)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt33']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt35'] then

                    wait(3.4)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt34']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt36'] then

                    wait(3.5)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt35']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt37'] then

                    wait(3.6)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt36']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt38'] then

                    wait(3.6)

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt37']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

                end

            end

            getgenv().LGF_StackLadderAlts(getgenv().MUF_ReturnClosestPlayer(args[2]))

        else

            getgenv().MUF_sendChatMessage('Unknown Player')

        end

    else

        if getgenv().CA_IsFreezing == true then

            getgenv().CA_IsFreezing = false

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

        end

        if getgenv().CA_IsAirlocking == true then

            getgenv().CA_IsAirlocking = false

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

        end

        if getgenv().CA_IsGraving == true then

            getgenv().CA_IsGraving = false

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

        end

        getgenv().LGF_StackLadderAlts = function(TheTarget)

            if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt2'] then

                wait(0.1)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt1']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt3'] then

                wait(0.2)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt2']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt4'] then

                wait(0.3)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt3']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt5'] then

                wait(0.4)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt4']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt6'] then

                wait(0.5)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt5']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt7'] then

                wait(0.6)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt6']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt8'] then

                wait(0.7)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt7']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt9'] then

                wait(0.8)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt8']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt10'] then

                wait(0.9)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt9']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt11'] then

                wait(1)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt10']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt12'] then

                wait(1.1)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt11']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt13'] then

                wait(1.2)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt12']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt14'] then

                wait(1.3)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt13']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt15'] then

                wait(1.4)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt14']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt16'] then

                wait(1.5)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt15']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt17'] then

                wait(1.6)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt16']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt18'] then

                wait(1.7)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt17']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt19'] then

                wait(1.8)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt18']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt20'] then

                wait(1.9)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt19']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt21'] then

                wait(2)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt20']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt22'] then

                wait(2.1)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt21']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt23'] then

                wait(2.2)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt22']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt24'] then

                wait(2.3)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt23']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt25'] then

                wait(2.4)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt24']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt26'] then

                wait(2.5)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt25']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt27'] then

                wait(2.6)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt26']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt28'] then

                wait(2.7)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt27']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt29'] then

                wait(2.8)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt28']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt30'] then

                wait(2.9)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt29']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt31'] then

                wait(3)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt30']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt32'] then

                wait(3.1)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt31']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt33'] then

                wait(3.2)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt32']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt34'] then

                wait(3.3)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt33']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt35'] then

                wait(3.4)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt34']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt36'] then

                wait(3.5)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt35']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt37'] then

                wait(3.6)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt36']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            elseif game.Players.LocalPlayer.UserId == getgenv().alts['Alt38'] then

                wait(3.6)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = getgenv().PlayersService:GetPlayerByUserId(getgenv().alts['Alt37']).Character:FindFirstChild('Head').CFrame * CFrame.new(0, 2, 0)

            end

        end

        getgenv().LGF_StackLadderAlts(game.Players:FindFirstChild(getgenv().PlayersService:GetNameFromUserIdAsync(tonumber(getgenv().controller))))

    end

    getgenv().MUF_sendChatMessage("Stacked up to controller's head!")

end

getgenv().HasRunnedWalletOfCMD = true



getgenv().WalletOfCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            getgenv().MUF_sendChatMessage(getgenv().MUF_ReturnClosestPlayer(args[2])..': '..getgenv().MUF_updateText(getgenv().MUF_ReturnClosestPlayer(args[2]):FindFirstChild('DataFolder'):FindFirstChild('Currency').Value))

        end

    else

        getgenv().MUF_sendChatMessage(game.Players.LocalPlayer.Name..': '..getgenv().MUF_updateText(game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value))

    end

end

getgenv().HasRunnedCircleCMD = true



getgenv().CircleCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            local hrp = getgenv().MUF_ReturnClosestPlayer(args[2]).Character:FindFirstChild('HumanoidRootPart')



            local fullCircle = 2 * math.pi

            local radius = 10

            

            local function getXAndZPositions(angle)

                local x = math.cos(angle) * radius

                local z = math.sin(angle) * radius

                return x, z

            end

            

            local angle = math.random(1, getgenv().maxAltsNumber) * (fullCircle / getgenv().maxAltsNumber)

            local x, z = getXAndZPositions(angle)

            

            local position = (hrp.CFrame * CFrame.new(x, 0, z)).p

            local lookAt = hrp.Position

            

            game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(position, lookAt)

        else

            getgenv().MUF_sendChatMessage('Unknown Player')

        end

    else

        local hrp = getgenv().PlayersService:FindFirstChild(getgenv().PlayersService:GetNameFromUserIdAsync(tonumber(getgenv().controller))).Character:FindFirstChild('HumanoidRootPart')



        local fullCircle = 2 * math.pi

        local radius = 10

        

        local function getXAndZPositions(angle)

            local x = math.cos(angle) * radius

            local z = math.sin(angle) * radius

            return x, z

        end

        

        local angle = math.random(1, getgenv().maxAltsNumber) * (fullCircle / getgenv().maxAltsNumber)

        local x, z = getXAndZPositions(angle)

        

        local position = (hrp.CFrame * CFrame.new(x, 0, z)).p

        local lookAt = hrp.Position

        

        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(position, lookAt)

    end

end

getgenv().HasRunnedQuickCMD = true



getgenv().QuickCMD = function(args)

    if args[2] then

        if args[2]:lower() == 'bank' then

            getgenv().LGF_TeleportAltsToBank = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-391.28, 21.47, -339.90)

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-383.29, 21.47, -340.17)

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-373.30, 21.47, -340.27)

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-364.55, 21.47, -339.91)

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-357.42, 21.47, -339.57)

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-391.72, 21.47, -330.29)

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-384.14, 21.47, -329.72)

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-376.74, 21.47, -329.23)

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-368.96, 21.47, -328.89)

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-357.75, 21.47, -328.77)

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-391.41, 21.47, -320.83)

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-383.24, 21.47, -320.56)

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-374.50, 21.47, -320.36)

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-366.63, 21.47, -320.08)

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-357.28, 21.47, -319.69)

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-392.12, 21.47, -314.77)

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-382.59, 21.47, -314.46)

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-375.08, 21.47, -314.32)

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-366.51, 21.47, -314.33)

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-357.26, 21.47, -314.34)

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-391.79, 21.47, -306.36)

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-383.13, 21.47, -305.72)

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-376.17, 21.47, -305.72)

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-366.60, 21.47, -305.74)

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-356.97, 21.47, -305.65)

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-391.82, 21.47, -297.73)

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-384.21, 21.47, -297.12)

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-375.70, 21.47, -296.77)

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-365.36, 21.47, -296.49)

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-356.83, 21.47, -295.41)

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-391.72, 21.47, -285.29)

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-383.71, 21.47, -284.95)

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-376.02, 21.47, -284.64)

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-365.46, 21.47, -283.57)

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-356.78, 21.47, -283.06)

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-383.89, 21.47, -273.47)

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-375.95, 21.47, -273.37)

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-366.85, 21.47, 272.94)

                end

            end

            getgenv().LGF_TeleportAltsToBank()

            wait(1)

            getgenv().CA_IsFreezing = true

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

            wait(1)

            getgenv().CA_Dropping = true

            local LF_Loop

            local LF_loopFunction = function(amount)

                game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', tostring(amount))

            end;

            local LF_Start = function(amount)

                LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                    LF_loopFunction(amount)

                end)

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                if getgenv().CA_DroppingUntil == true then

                    getgenv().CA_DroppingUntil = false

                    getgenv().CA_DropUntilAmount = 0

                end

                if game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000 then

                    getgenv().MUF_sendChatMessage("I don't have enough money, must have atleast 10K")

                end

                getgenv().MUF_sendChatMessage('Stopped Auto Drop')

            end;

        

            LF_Start(10000)

            repeat wait() until getgenv().CA_Dropping == false or getgenv().CA_DroppingUntil == true or game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000

            LF_Pause()

        elseif args[2]:lower() == 'admin' then

            getgenv().LGF_TeleportAltsToAdminBase = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-894.8657836914062, -39.401187896728516, -553.9047241210938) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-895.1825561523438, -39.401187896728516, -567.8170776367188) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-895.1011352539062, -38.901187896728516, -580.698974609375) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-895.02099609375, -38.901187896728516, -593.3446044921875) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-894.9393310546875, -39.10118865966797, -606.1416015625) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-880.18701171875, -38.40118408203125, -554.1747436523438) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-880.10009765625, -38.40118408203125, -567.90576171875) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-880.017333984375, -38.40118408203125, -580.9703369140625) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-879.9363403320312, -38.40118408203125, -593.6342163085938) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-880.517822265625, -38.40118408203125, -607.0358276367188) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.4531860351562, -38.401187896728516, -554.8992919921875) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.2959594726562, -38.401187896728516, -567.2496948242188) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.4403076171875, -38.401187896728516, -580.424560546875) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.5025024414062, -38.401187896728516, -594.418212890625) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.2288208007812, -38.401187896728516, -607.0742797851562) -- 15

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-850.0700073242188, -39.401187896728516, -555.0064086914062) -- 16

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-850.3143310546875, -39.401187896728516, -567.9920043945312) -- 17

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-850.1458129882812, -38.901187896728516, -581.055419921875) -- 18

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-850.1414794921875, -38.901187896728516, -593.385498046875) -- 19

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-850.2012939453125, -39.20118713378906, -606.4415893554688) -- 20

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-910.5515747070312, -39.401187896728516, -556.05615234375) -- 21

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-910.5818481445312, -39.401187896728516, -568.9136352539062) -- 22

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-910.4556274414062, -38.901187896728516, -582.5003662109375) -- 23

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-909.4376831054688, -38.901187896728516, -594.9976806640625) -- 24

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-910.2506103515625, -39.20118713378906, -606.5593872070312) -- 25

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-832.2540283203125, -39.401187896728516, -555.3170776367188) -- 26

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-832.2061157226562, -39.401187896728516, -568.3141479492188) -- 27

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-832.3546752929688, -38.901187896728516, -581.8248291015625) -- 28

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-832.4812622070312, -38.901187896728516, -593.3547973632812) -- 29

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-832.4165649414062, -39.20118713378906, -606.3519287109375) -- 30

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-831.1634521484375, -39.401187896728516, -620.0548095703125) -- 31

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-849.4916381835938, -39.401187896728516, -619.0955810546875) -- 32

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-864.494384765625, -38.401187896728516, -618.0387573242188) -- 33

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-880.2246704101562, -38.401187896728516, -618.1248168945312) -- 34

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-894.1553955078125, -39.401187896728516, -618.201171875) -- 35

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-910.26953125, -39.163795471191406, -618.8297729492188) -- 36

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-872.030029296875, -38.401187896728516, -585.260009765625) -- 37

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-872.5477294921875, -38.401187896728516, -629.4262084960938) -- 38

                end

            end

            getgenv().LGF_TeleportAltsToAdminBase()

            wait(1)

            getgenv().CA_IsFreezing = true

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

            wait(1)

            getgenv().CA_Dropping = true

            local LF_Loop

            local LF_loopFunction = function(amount)

                game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', tostring(amount))

            end;

            local LF_Start = function(amount)

                LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                    LF_loopFunction(amount)

                end)

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                if getgenv().CA_DroppingUntil == true then

                    getgenv().CA_DroppingUntil = false

                    getgenv().CA_DropUntilAmount = 0

                end

                if game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000 then

                    getgenv().MUF_sendChatMessage("I don't have enough money, must have atleast 10K")

                end

                getgenv().MUF_sendChatMessage('Stopped Auto Drop')

            end;

        

            LF_Start(10000)

            repeat wait() until getgenv().CA_Dropping == false or getgenv().CA_DroppingUntil == true or game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000

            LF_Pause()

        elseif args[2]:lower() == 'school' then

            getgenv().LGF_TeleportAltsToSchool = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-667.28, 21.57, 200.55)

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-667.14, 21.57, 195.61)

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-667.50, 21.54, 190.11)

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-667.44, 21.54, 185.01)

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-667.03, 21.57, 179.96)

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-651.46, 21.54, 180.03)

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-651.006, 21.57, 185.26)

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-651.08, 21.57, 190.44)

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-651.16, 21.59, 195.66)

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-651.23, 21.57, 200.25)

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-635.14, 21.57, 200.33)

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-635.19, 21.59, 194.75)

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-635.22, 21.57, 190.63)

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-635.27, 21.57, 185.34)

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-635.19, 21.59, 180.07)

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-619.30, 21.57, 180.26)

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-619.37, 21.57, 185.89)

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-619.37, 21.57, 185.89)

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-619.35, 21.57, 194.72)

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-619.39, 21.57, 200.39)

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-603.34, 21.57, 200.41)

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-603.30, 21.57, 194.64)

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-603.28, 21.57, 190.98)

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-603.31, 21.57, 185.86)

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-603.36, 21.57, 180.40)

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-587.23, 21.57, 180.33)

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-587.31, 21.57, 185.28)

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-587.27, 21.57, 190.66)

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-587.31, 21.57, 195.06)

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-587.35, 21.57, 200.38)

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-571.18, 21.59, 200.28)

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-571.24, 21.57, 194.75)

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-571.23, 21.57, 190.57)

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-571.19, 21.59, 184.82)

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-571.18, 21.59, 180.05)

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-554.87, 21.54, 179.98)

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-555.30, 21.57, 190.88)

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-554.97, 21.57, 200.51)

                end

            end

            getgenv().LGF_TeleportAltsToSchool()

            wait(1)

            getgenv().CA_IsFreezing = true

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

            wait(1)

            getgenv().CA_Dropping = true

            local LF_Loop

            local LF_loopFunction = function(amount)

                game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', tostring(amount))

            end;

            local LF_Start = function(amount)

                LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                    LF_loopFunction(amount)

                end)

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                if getgenv().CA_DroppingUntil == true then

                    getgenv().CA_DroppingUntil = false

                    getgenv().CA_DropUntilAmount = 0

                end

                if game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000 then

                    getgenv().MUF_sendChatMessage("I don't have enough money, must have atleast 10K")

                end

                getgenv().MUF_sendChatMessage('Stopped Auto Drop')

            end;

        

            LF_Start(10000)

            repeat wait() until getgenv().CA_Dropping == false or getgenv().CA_DroppingUntil == true or game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000

            LF_Pause()

        elseif args[2]:lower() == 'train' then

            getgenv().LGF_TeleportAltsToTrain = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(682.56, 54.22, -37.60) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(689.49, 54.22, -45.47) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(675.29, 54.22, -31.27) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(670.96, 50.92, -31.29) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(680.15, 51.22, -40.24) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(689.46, 50.92, -49.59) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(689.51, 48.22, -53.97) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(677.69, 48.22, -42.003) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(667.49, 48.52, -31.30) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(652.60, 48.22, -31.30) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(657.12, 48.22, -41.79) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(663.90, 48.22, -48.21) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(670.72, 48.22, -54.84) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(678.75, 48.22, 58.40) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(689.43, 48.22, -53.23) -- 15

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(689.43, 48.22, -72.98) -- 16

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(678.20, 48.22, -72.46) -- 17

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(668.98, 48.22, -71.50) -- 18

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(667.57, 48.22, -63.16) -- 19

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(663.90, 48.22, -55.58) -- 20

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(657.65, 48.22, -51.38) -- 21

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(649.95, 48.22, -49.65) -- 22

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(646.94, 48.22, -41.11) -- 23

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(646.19, 48.22, -31.61) -- 24

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(585.20, 48.22, -31.04) -- 25

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(689.41, 48.22, -104.16) -- 26

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(676.95, 48.22, -104.59) -- 27

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(663.93, 48.22, -104.17) -- 28

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(654.50, 48.22, -104.35) -- 29

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(645.42, 48.22, -104.60) -- 30

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(601.35, 48.22, -80.73) -- 31

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(601.30, 48.22, -70.28) -- 32

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(600.14, 48.22, -57.46) -- 33

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(600.02, 48.22, -48.76) -- 34

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(599.85, 48.22, -40.82) -- 35

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(599.68, 48.22, -31.60) -- 36

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(560.86, 34.72, -109.40) -- 37

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(599.76, 34.72, -147.70) -- 38

                end

            end

            getgenv().LGF_TeleportAltsToTrain()

            wait(1)

            getgenv().CA_IsFreezing = true

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

            wait(1)

            getgenv().CA_Dropping = true

            local LF_Loop

            local LF_loopFunction = function(amount)

                game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', tostring(amount))

            end;

            local LF_Start = function(amount)

                LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                    LF_loopFunction(amount)

                end)

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                if getgenv().CA_DroppingUntil == true then

                    getgenv().CA_DroppingUntil = false

                    getgenv().CA_DropUntilAmount = 0

                end

                if game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000 then

                    getgenv().MUF_sendChatMessage("I don't have enough money, must have atleast 10K")

                end

                getgenv().MUF_sendChatMessage('Stopped Auto Drop')

            end;

        

            LF_Start(10000)

            repeat wait() until getgenv().CA_Dropping == false or getgenv().CA_DroppingUntil == true or game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000

            LF_Pause()

        elseif args[2]:lower() == 'sz3' then

            getgenv().LGF_TeleportAltsToSafeZone3 = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.99, 11.97, 140.87) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.83, 11.97, 149.44) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.91, 11.97, 155.38) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.63, 11.97, 161.93) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.92, 11.97, 170.36) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.92, 11.97, 179.78) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.92, 11.97, 188.84) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.92, 11.97, 196.79) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.90, 11.97, 202.49) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(116.86, 11.97, 207.80) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(110.61, 11.97, 140.79) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(104.001, 11.97, 140.75) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(97.45, 11.97, 140.74) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(91.25, 11.97, 140.77) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(83.17, 11.97, 140.83) -- 15

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(43.24, 11.97, 229.46) -- 16

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(1.03, 11.97, 227.0008) -- 17

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(5.14, 11.97, 183.36) -- 18

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(58.89, 11.97, 187.58) -- 19

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(59.38, 11.97, 231.52) -- 20

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(22.82, 11.97, 173.35) -- 21

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(2.19, 11.97, 166.10) -- 22

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(20.32, 11.97, 138.25) -- 23

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-73.72, 11.97, 158.55) -- 24

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-47.009, 11.97, 221.87) -- 25

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-39.94, 11.97, 291.63) -- 26

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(61.19, 11.46, 314.27) -- 27

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(149.73, 11.97, 278.57) -- 28

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(161.85, 11.97, 227.36) -- 29

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(188.18, 11.97, 255.59) -- 30

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(183.31, 11.97, 323.88) -- 31

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-18.65, 11.46, 309.80) -- 32

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-67.12, 11.46, 309.08) -- 33

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-93.52, 11.97, 182.95) -- 34

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-112.14, 11.97, 147.14) -- 35

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-81.84, 11.97, 118.44) -- 36

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-52.58, 11.97, 142.57) -- 37

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(1.64, 11.97, 180.62) -- 38

                end

            end

            getgenv().LGF_TeleportAltsToSafeZone3()

            wait(1)

            getgenv().CA_IsFreezing = true

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

            wait(1)

            getgenv().CA_Dropping = true

            local LF_Loop

            local LF_loopFunction = function(amount)

                game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', tostring(amount))

            end;

            local LF_Start = function(amount)

                LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                    LF_loopFunction(amount)

                end)

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                if getgenv().CA_DroppingUntil == true then

                    getgenv().CA_DroppingUntil = false

                    getgenv().CA_DropUntilAmount = 0

                end

                if game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000 then

                    getgenv().MUF_sendChatMessage("I don't have enough money, must have atleast 10K")

                end

                getgenv().MUF_sendChatMessage('Stopped Auto Drop')

            end;

        

            LF_Start(10000)

            repeat wait() until getgenv().CA_Dropping == false or getgenv().CA_DroppingUntil == true or game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000

            LF_Pause()

        elseif args[2]:lower() == 'basket' then

            getgenv().LGF_TeleportAltsToBasket = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-994.48, 22.22, -482.50) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-963.27, 22.22, -482.23) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-969.70, 22.22, -482.20) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-974.50, 22.22, -493.81) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-980.78, 22.22, -493.28) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-986.61, 22.22, -493.32) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-993.15, 22.22, -491.21) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-993.40, 22.22, -473.13) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-986.64, 22.22, -471.45) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-980.88, 22.22, -471.29) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-974.70, 22.22, -471.20) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-947.43, 22.22, -480.84) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-916.27, 22.22, -482.99) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-931.92, 22.32, -499.14) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-932.08, 22.32, -466.60) -- 15

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-901.07, 22.22, -482.40) -- 16

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-895.41, 22.22, -482.17) -- 17

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-881.51, 22.22, -481.50) -- 18

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-870.54, 22.22, -481.74) -- 19

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-870.80, 22.22, -491.50) -- 20

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-877.98, 22.22, -493.72) -- 21

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-883.66, 22.22, -493.51) -- 22

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-889.99, 22.24, -493.18) -- 23

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(890.13, 22.22, -470.95) -- 24

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-883.04, 22.22, -470.82) -- 25

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-877.11, 22.22, -470.65) -- 26

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-877.11, 22.22, -470.65) -- 27

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-916.20, 22.22, -447.37) -- 28

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-918.20, 22.22, -510.33) -- 29

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-946.74, 22.22, -512.40) -- 30

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-995.52, 22.22, -442.49) -- 31

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-998.19, 22.22, -522.27) -- 32

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-932.65, 22.30, -517.69) -- 33

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-916.16, 22.22, -469.66) -- 34

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-916.23, 22.22, -491.62) -- 35

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-942.91, 22.22, -491.94) -- 36

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-943.32, 22.22, -469.68) -- 37

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-918.70, 22.22, -527.38) -- 38

                end

            end

            getgenv().LGF_TeleportAltsToBasket()

            wait(1)

            getgenv().CA_IsFreezing = true

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

            wait(1)

            getgenv().CA_Dropping = true

            local LF_Loop

            local LF_loopFunction = function(amount)

                game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', tostring(amount))

            end;

            local LF_Start = function(amount)

                LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                    LF_loopFunction(amount)

                end)

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                if getgenv().CA_DroppingUntil == true then

                    getgenv().CA_DroppingUntil = false

                    getgenv().CA_DropUntilAmount = 0

                end

                if game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000 then

                    getgenv().MUF_sendChatMessage("I don't have enough money, must have atleast 10K")

                end

                getgenv().MUF_sendChatMessage('Stopped Auto Drop')

            end;

        

            LF_Start(10000)

            repeat wait() until getgenv().CA_Dropping == false or getgenv().CA_DroppingUntil == true or game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000

            LF_Pause()

        elseif args[2]:lower() == 'taco' then

            getgenv().LGF_TeleportAltsToTacoShop = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(503.8083190917969, 48.25498962402344, -587.053466796875) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(503.7886962890625, 47.75498962402344, -579.1676025390625) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(503.68572998046875, 47.75498962402344, -571.37060546875) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(503.62548828125, 47.75498962402344, -565.5831909179688) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(503.4499816894531, 47.75498962402344, -558.89794921875) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(503.28167724609375, 47.75498962402344, -552.487548828125) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(506.59326171875, 48.2499885559082, -550.990478515625) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(512.0355834960938, 48.243621826171875, -551.0362548828125) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(517.7601318359375, 48.236480712890625, -550.96484375) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(523.5612182617188, 48.220787048339844, -550.878662109375) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(530.76025390625, 48.13629150390625, -550.52099609375) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(537.3292236328125, 48.17863464355469, -550.6953125) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(543.8451538085938, 48.23771286010742, -550.9771118164062) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(551.0494384765625, 48.217254638671875, -550.8612670898438) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(560.3720092773438, 48.1821403503418, -550.7071533203125) -- 15

                elseif getgenv().alts['Alt16'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(568.7127075195312, 48.1568717956543, -550.609375) -- 16

                elseif getgenv().alts['Alt17'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(576.4111328125, 48.13755416870117, -550.5252075195312) -- 17

                elseif getgenv().alts['Alt18'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(576.324462890625, 47.75498962402344, -556.4823608398438) -- 18

                elseif getgenv().alts['Alt19'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(576.8931884765625, 47.864906311035156, -562.1771240234375) -- 19

                elseif getgenv().alts['Alt20'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(576.9207763671875, 47.864906311035156, -566.76904296875) -- 20

                elseif getgenv().alts['Alt21'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(577.0294799804688, 47.864906311035156, -573.403076171875) -- 21

                elseif getgenv().alts['Alt22'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(577.880126953125, 47.864906311035156, -580.0341186523438) -- 22

                elseif getgenv().alts['Alt23'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(578.1847534179688, 47.864906311035156, -582.9446411132812) -- 23

                elseif getgenv().alts['Alt24'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(578.4891967773438, 48.154991149902344, -587.8359985351562) -- 24

                elseif getgenv().alts['Alt25'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(571.4197998046875, 48.154991149902344, -587.8607788085938) -- 25

                elseif getgenv().alts['Alt26'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(564.643798828125, 48.154991149902344, -587.962158203125) -- 26

                elseif getgenv().alts['Alt27'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(557.6697387695312, 48.154991149902344, -587.9202880859375) -- 27

                elseif getgenv().alts['Alt28'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(550.6521606445312, 48.154991149902344, -587.88427734375) -- 28

                elseif getgenv().alts['Alt29'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(543.4424438476562, 48.154991149902344, -587.9168701171875) -- 29

                elseif getgenv().alts['Alt30'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(535.1602172851562, 48.154991149902344, -587.9348754882812) -- 30

                elseif getgenv().alts['Alt31'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(528.3248291015625, 48.1049919128418, -588.0411987304688) -- 31

                elseif getgenv().alts['Alt32'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(522.1769409179688, 48.1049919128418, -588.0496826171875) -- 32

                elseif getgenv().alts['Alt33'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(518.077880859375, 48.20499038696289, -587.7919921875) -- 33

                elseif getgenv().alts['Alt34'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(510.9388122558594, 48.20499038696289, -587.7742919921875) -- 34

                elseif getgenv().alts['Alt35'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(503.7898254394531, 48.154991149902344, -587.8549194335938) -- 35

                elseif getgenv().alts['Alt36'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(528.8453369140625, 47.75498962402344, -572.5838623046875) -- 36

                elseif getgenv().alts['Alt37'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(560.9296264648438, 47.75498962402344, -572.4683227539062) -- 37

                elseif getgenv().alts['Alt38'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(590.3792724609375, 47.864906311035156, -572.654541015625) -- 38

                end

            end

            getgenv().LGF_TeleportAltsToBasket()

            wait(1)

            getgenv().CA_IsFreezing = true

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

            wait(1)

            getgenv().CA_Dropping = true

            local LF_Loop

            local LF_loopFunction = function(amount)

                game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', tostring(amount))

            end;

            local LF_Start = function(amount)

                LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                    LF_loopFunction(amount)

                end)

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                if getgenv().CA_DroppingUntil == true then

                    getgenv().CA_DroppingUntil = false

                    getgenv().CA_DropUntilAmount = 0

                end

                if game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000 then

                    getgenv().MUF_sendChatMessage("I don't have enough money, must have atleast 10K")

                end

                getgenv().MUF_sendChatMessage('Stopped Auto Drop')

            end;

        

            LF_Start(10000)

            repeat wait() until getgenv().CA_Dropping == false or getgenv().CA_DroppingUntil == true or game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000

            LF_Pause()

        elseif args[2]:lower() == 'jail' then

            getgenv().LGF_TeleportAltsToBasket()

            wait(1)

            getgenv().CA_IsFreezing = true

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

            wait(1)

            getgenv().CA_Dropping = true

            local LF_Loop

            local LF_loopFunction = function(amount)

                game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', tostring(amount))

            end;

            local LF_Start = function(amount)

                LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                    LF_loopFunction(amount)

                end)

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                if getgenv().CA_DroppingUntil == true then

                    getgenv().CA_DroppingUntil = false

                    getgenv().CA_DropUntilAmount = 0

                end

                if game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000 then

                    getgenv().MUF_sendChatMessage("I don't have enough money, must have atleast 10K")

                end

                getgenv().MUF_sendChatMessage('Stopped Auto Drop')

            end;

        

            LF_Start(10000)

            repeat wait() until getgenv().CA_Dropping == false or getgenv().CA_DroppingUntil == true or game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000

            LF_Pause()

        elseif args[2]:lower() == 'undertrain' then

            getgenv().LGF_TeleportAltsToUnderTrain()

            wait(1)

            getgenv().CA_IsFreezing = true

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

            wait(1)

            getgenv().CA_Dropping = true

            local LF_Loop

            local LF_loopFunction = function(amount)

                game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', tostring(amount))

            end;

            local LF_Start = function(amount)

                LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                    LF_loopFunction(amount)

                end)

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                if getgenv().CA_DroppingUntil == true then

                    getgenv().CA_DroppingUntil = false

                    getgenv().CA_DropUntilAmount = 0

                end

                if game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000 then

                    getgenv().MUF_sendChatMessage("I don't have enough money, must have atleast 10K")

                end

                getgenv().MUF_sendChatMessage('Stopped Auto Drop')

            end;

        

            LF_Start(10000)

            repeat wait() until getgenv().CA_Dropping == false or getgenv().CA_DroppingUntil == true or game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000

            LF_Pause()

        elseif args[2]:lower() == 'club' then

            getgenv().LGF_TeleportAltsToClub()

            wait(1)

            getgenv().CA_IsFreezing = true

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

            wait(1)

            getgenv().CA_Dropping = true

            local LF_Loop

            local LF_loopFunction = function(amount)

                game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', tostring(amount))

            end;

            local LF_Start = function(amount)

                LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                    LF_loopFunction(amount)

                end)

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                if getgenv().CA_DroppingUntil == true then

                    getgenv().CA_DroppingUntil = false

                    getgenv().CA_DropUntilAmount = 0

                end

                if game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000 then

                    getgenv().MUF_sendChatMessage("I don't have enough money, must have atleast 10K")

                end

                getgenv().MUF_sendChatMessage('Stopped Auto Drop')

            end;

        

            LF_Start(10000)

            repeat wait() until getgenv().CA_Dropping == false or getgenv().CA_DroppingUntil == true or game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000

            LF_Pause()

        end

    else

        getgenv().MUF_sendChatMessage('Please Specify location to quick setup in')

    end

end

getgenv().HasRunnedFlyAnimCMD = true



getgenv().FlyAnimCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                game.Players.LocalPlayer.UserId = 2607519759

                loadstring(game:HttpGet('https://raw.githubusercontent.com/22kristina/swag/main/admin_fly'))()

                getgenv().MUF_sendChatMessage('Loaded Swag Admin Fly Animation!')

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        game.Players.LocalPlayer.UserId = 2607519759

        loadstring(game:HttpGet('https://raw.githubusercontent.com/22kristina/swag/main/admin_fly'))()

        getgenv().MUF_sendChatMessage('Loaded Swag Admin Fly Animation!')

    end

end

getgenv().HasRunnedDupeCMD = true



getgenv().DupeCMD = function(args)

    if getgenv().CA_Dropping == true then

        getgenv().CA_Dropping = false

    end

    if getgenv().CA_AutoCashPickup == true then

        getgenv().CA_AutoCashPickup = false

    end

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if getgenv().CA_AutoCashPickup == false then

                    getgenv().CA_AutoCashPickup = true

                    getgenv().MUF_sendChatMessage('Started Picking Up For Dupe')

                    local LF_Loop

                    local LF_loopFunction = function()

                        for i, thechild in pairs(game.Workspace:WaitForChild('Ignored'):WaitForChild('Drop'):GetChildren()) do

                            if thechild.Name == 'MoneyDrop' or thechild.Name == 'MoneyDropCounted' then

                                if game.Players.LocalPlayer:DistanceFromCharacter(thechild.Position) < 13 then

                                    fireclickdetector(thechild:FindFirstChild('ClickDetector'), 12)

                                end

                            end

                        end

                    end;

                    local LF_Start = function()

                        LF_Loop = RunService.Heartbeat:Connect(LF_loopFunction);

                    end;

                    local LF_Pause = function()

                        LF_Loop:Disconnect()

                        getgenv().MUF_sendChatMessage('Stopped Cashaura')

                    end;

                

                    LF_Start()

                    repeat wait() until getgenv().CA_AutoCashPickup == false

                    LF_Pause()

                else

                    getgenv().CA_AutoCashPickup = false

                end

            else

                if getgenv().CA_Dropping == false then

                    getgenv().CA_Dropping = true

                    getgenv().MUF_sendChatMessage('Started Dropping For Dupe')

                    local LF_Loop

                    local LF_loopFunction = function(amount)

                        game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', tostring(amount))

                    end;

                    local LF_Start = function(amount)

                        LF_Loop = RunService.Heartbeat:Connect(function()

                            LF_loopFunction(amount)

                        end)

                    end;

                    local LF_Pause = function()

                        LF_Loop:Disconnect()

                        if getgenv().CA_DroppingUntil == true then

                            getgenv().CA_DroppingUntil = false

                            getgenv().CA_DropUntilAmount = 0

                        end

                        if game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000 then

                            getgenv().MUF_sendChatMessage("I don't have enough money, must have atleast 10K")

                        end

                        getgenv().MUF_sendChatMessage('Stopped Auto Drop')

                    end;

                

                    LF_Start(10000)

                    repeat wait() until getgenv().CA_Dropping == false or getgenv().CA_DroppingUntil == true or game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000

                    LF_Pause()

                else

                    getgenv().CA_Dropping = false

                    getgenv().MUF_sendChatMessage('Stopped Dropping For Dupe')

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        getgenv().MUF_sendChatMessage('Specify which alt to dupe in')

    end

end

getgenv().HasRunnedBenxCMD = true



getgenv().BenxCMD = function(args)

    local Crouch = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid'):LoadAnimation(game:GetService("ReplicatedStorage").ClientAnimations.Crouching)

    Crouch.Looped = true

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if getgenv().CA_Benxing == false then

                    getgenv().CA_Benxing = true

                    Crouch:Play()

                    getgenv().MUF_sendChatMessage('Started Benxing')

                    local LF_Loop

                    local LF_loopFunction = function(TheTarget)

                        if game.Players.LocalPlayer.Character:FindFirstChild('Pants') then

                            game.Players.LocalPlayer.Character:FindFirstChild('Pants'):Destroy()

                        end

                        if game.Players.LocalPlayer.Character:FindFirstChild('Shirt') then

                            game.Players.LocalPlayer.Character:FindFirstChild('Shirt'):Destroy()

                        end

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame + TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame.lookVector * 0.5

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Velocity = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame.lookVector * 70

                        wait(0.1)

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Velocity = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame.lookVector * -200

                    end;

                    local LF_Start = function(TheTarget)

                        LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                            LF_loopFunction(TheTarget)

                        end)

                    end;

                    local LF_Pause = function()

                        LF_Loop:Disconnect()

                        getgenv().MUF_sendChatMessage('Stopped Benxing')

                        Crouch:Stop()

                    end;

                    LF_Start(getgenv().PlayersService:FindFirstChild(getgenv().PlayersService:GetNameFromUserIdAsync(tonumber(getgenv().controller))))

                    repeat wait() until getgenv().CA_Benxing == false

                    LF_Pause()

                else

                    getgenv().CA_Benxing = false

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        if getgenv().CA_Benxing == false then

            getgenv().CA_Benxing = true

            Crouch:Play()

            getgenv().MUF_sendChatMessage('Started Benxing')

            local LF_Loop

            local LF_loopFunction = function(TheTarget)

                if game.Players.LocalPlayer.Character:FindFirstChild('Pants') then

                    game.Players.LocalPlayer.Character:FindFirstChild('Pants'):Destroy()

                end

                if game.Players.LocalPlayer.Character:FindFirstChild('Shirt') then

                    game.Players.LocalPlayer.Character:FindFirstChild('Shirt'):Destroy()

                end

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame + TheTarget.Character:FindFirstChild('HumanoidRootPart').CFrame.lookVector * 0.5

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Velocity = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame.lookVector * 70

                wait(0.1)

                game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Velocity = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame.lookVector * -200

            end;

            local LF_Start = function(TheTarget)

                LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                    LF_loopFunction(TheTarget)

                end)

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                getgenv().MUF_sendChatMessage('Stopped Benxing')

                Crouch:Stop()

            end;

        

            LF_Start(getgenv().PlayersService:FindFirstChild(getgenv().PlayersService:GetNameFromUserIdAsync(tonumber(getgenv().controller))))

            repeat wait() until getgenv().CA_Benxing == false

            LF_Pause()

        else

            getgenv().CA_Benxing = false

        end

    end

end

getgenv().HasRunnedGraveCMD = true



getgenv().GraveCMD = function(args)

    if args[2] then

        if args[2]:lower() == 'all' then

            if getgenv().CA_IsGraving == true then

                getgenv().CA_IsGraving = false

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getgenv().PlayersService:FindFirstChild(getgenv().PlayersService:GetNameFromUserIdAsync(tonumber(getgenv().controller))).Character.HumanoidRootPart.Position

                getgenv().MUF_sendChatMessage('I am on the ground now!')

            else

                getgenv().CA_IsGraving = true

                if getgenv().CA_IsFreezing == true then

                    getgenv().CA_IsFreezing = false

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                end

                if getgenv().CA_IsAirlocking == true then

                    getgenv().CA_IsAirlocking = false

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                end

                if args[3] then

                    if tonumber(args[3]) then

                        local plrpos = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(plrpos.X, plrpos.Y - tonumber(args[3]), plrpos.Z)

                        wait(0.01)

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

                        getgenv().MUF_sendChatMessage('Graved!')

                    else

                        getgenv().MUF_sendChatMessage('Argument 3 must be number')

                    end

                else

                    local plrpos = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(plrpos.X, plrpos.Y - 7, plrpos.Z)

                    wait(0.01)

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

                    getgenv().MUF_sendChatMessage('Graved!')

                end

            end

        elseif getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if getgenv().CA_IsGraving == true then

                    getgenv().CA_IsGraving = false

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getgenv().PlayersService:FindFirstChild(getgenv().PlayersService:GetNameFromUserIdAsync(tonumber(getgenv().controller))).Character.HumanoidRootPart.Position

                    getgenv().MUF_sendChatMessage('I am on the ground now!')

                else

                    getgenv().CA_IsGraving = true

                    if getgenv().CA_IsFreezing == true then

                        getgenv().CA_IsFreezing = false

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                    end

                    if getgenv().CA_IsAirlocking == true then

                        getgenv().CA_IsAirlocking = false

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                    end

                    if args[3] then

                        if tonumber(args[3]) then

                            local plrpos = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

                            game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(plrpos.X, plrpos.Y - tonumber(args[3]), plrpos.Z)

                            wait(0.01)

                            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

                            getgenv().MUF_sendChatMessage('Graved!')

                        else

                            getgenv().MUF_sendChatMessage('Argument 3 must be number')

                        end

                    else

                        local plrpos = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(plrpos.X, plrpos.Y - 7, plrpos.Z)

                        wait(0.01)

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

                        getgenv().MUF_sendChatMessage('Graved!')

                    end

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        if getgenv().CA_IsGraving == true then

            getgenv().CA_IsGraving = false

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getgenv().PlayersService:FindFirstChild(getgenv().PlayersService:GetNameFromUserIdAsync(tonumber(getgenv().controller))).Character.HumanoidRootPart.Position

            getgenv().MUF_sendChatMessage('I am on the ground now!')

        else

            getgenv().CA_IsGraving = true

            if getgenv().CA_IsFreezing == true then

                getgenv().CA_IsFreezing = false

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            end

            if getgenv().CA_IsAirlocking == true then

                getgenv().CA_IsAirlocking = false

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            end

            local plrpos = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

            game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(plrpos.X, plrpos.Y - 7, plrpos.Z)

            wait(0.01)

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

            getgenv().MUF_sendChatMessage('Graved!')

        end

    end

end

getgenv().HasRunnedTpCMD = true



getgenv().TpCMD = function(args)

    if game.Players.LocalPlayer:FindFirstChild('Backpack'):FindFirstChild('Combat') then

        game.Players.LocalPlayer:FindFirstChild('Backpack'):FindFirstChild('Combat').Parent = game.Players.LocalPlayer.Character

    end

    if getgenv().CA_IsFreezing == true then

        getgenv().CA_IsFreezing = false

        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

    end

    if getgenv().CA_IsAirlocking == true then

        getgenv().CA_IsAirlocking = false

        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

    end

    if getgenv().CA_IsGraving == true then

        getgenv().CA_IsGraving = false

        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

    end

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if args[3] then

                local function TheBringKilling(thetarget)

                    for i=1, 100000000000 do

                        if getgenv().CA_BringLoopKill == false then

                            getgenv().MUF_sendChatMessage('Processing Kill..')

                            break

                        end

                        

                        if game.Players.LocalPlayer:FindFirstChild('Backpack'):FindFirstChild('Combat') then

                            wait(0.5)

                            game.Players.LocalPlayer:FindFirstChild('Backpack'):FindFirstChild('Combat').Parent = game.Players.LocalPlayer.Character

                            wait(0.3)

                            TheBringKilling(thetarget)

                        end

                        

                        if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script') and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script').Name ~= 'Health' then

                            game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script'):Destroy()

                            TheBringKilling(thetarget)

                        end

                

                        if game.Players.LocalPlayer.Character:FindFirstChild('BodyEffects'):FindFirstChild('K.O').Value == true then

                            game.Players.LocalPlayer.Character:FindFirstChild('Humanoid').Health = 0

                        end

                        

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(thetarget.Character:FindFirstChild('HumanoidRootPart').CFrame.X, thetarget.Character:FindFirstChild('HumanoidRootPart').CFrame.Y, thetarget.Character:FindFirstChild('HumanoidRootPart').CFrame.Z + 2)

                        game.Players.LocalPlayer.Character.Combat:Activate()

                        wait(0.05)

                        if thetarget.Character:FindFirstChild('BodyEffects'):FindFirstChild('K.O').Value == true then

                            getgenv().MUF_TheBring(thetarget)

                        end

                    end

                end

                if args[3]:lower() == 'bank' then

                    if args[4] then

                        if getgenv().MUF_ReturnClosestPlayer(args[4]) then

                            if getgenv().MUF_ReturnClosestPlayer(args[4]) == game.Players.LocalPlayer then

                                getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                                getgenv().CA_TheBringPosition = Vector3.new(-408.93, 21.74, -311)

                                getgenv().CA_BringLoopKill = true

                                TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                            end

                        else

                            getgenv().MUF_sendChatMessage('Unknown Alt')

                        end

                    else

                        if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                            getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                            getgenv().CA_TheBringPosition = Vector3.new(-408.93, 21.74, -311.13)

                            getgenv().CA_BringLoopKill = true

                            

                            TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                        end

                    end

                elseif args[3]:lower() == 'admin' then

                    if args[4] then

                        if getgenv().MUF_ReturnClosestPlayer(args[4]) then

                            if getgenv().MUF_ReturnClosestPlayer(args[4]) == game.Players.LocalPlayer then

                                getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                                getgenv().CA_TheBringPosition = Vector3.new(-872.099, -32.65, -644.19)

                                getgenv().CA_BringLoopKill = true

                                TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                            end

                        else

                            getgenv().MUF_sendChatMessage('Unknown Alt')

                        end

                    else

                        if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                            getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                            getgenv().CA_TheBringPosition = Vector3.new(-872.099, -32.65, -644.19)

                            getgenv().CA_BringLoopKill = true

                            TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                        end

                    end

                elseif args[3]:lower() == 'school' then

                    if args[4] then

                        if getgenv().MUF_ReturnClosestPlayer(args[4]) then

                            if getgenv().MUF_ReturnClosestPlayer(args[4]) == game.Players.LocalPlayer then

                                getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                                getgenv().CA_TheBringPosition = Vector3.new(-651.95, 21.74, 252.37)

                                getgenv().CA_BringLoopKill = true

                                TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                            end

                        else

                            getgenv().MUF_sendChatMessage('Unknown Alt')

                        end

                    else

                        if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                            getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                            getgenv().CA_TheBringPosition = Vector3.new(-651.95, 21.74, 252.37)

                            getgenv().CA_BringLoopKill = true

                            TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                        end

                    end

                elseif args[3]:lower() == 'train' then

                    if args[4] then

                        if getgenv().MUF_ReturnClosestPlayer(args[4]) then

                            if getgenv().MUF_ReturnClosestPlayer(args[4]) == game.Players.LocalPlayer then

                                getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                                getgenv().CA_TheBringPosition = Vector3.new(668.73, 47.99, -88.77)

                                getgenv().CA_BringLoopKill = true                                                        

                                TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                            end

                        else

                            getgenv().MUF_sendChatMessage('Unknown Alt')

                        end

                    else

                        if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                            getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                            getgenv().CA_TheBringPosition = Vector3.new(668.73, 47.99, -88.77)

                            getgenv().CA_BringLoopKill = true

                            TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                        end

                    end

                elseif args[3]:lower() == 'sz3' then

                    if args[4] then

                        if getgenv().MUF_ReturnClosestPlayer(args[4]) then

                            if getgenv().MUF_ReturnClosestPlayer(args[4]) == game.Players.LocalPlayer then

                                getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                                getgenv().CA_TheBringPosition = Vector3.new(7.99, 11.74, 170.75)

                                getgenv().CA_BringLoopKill = true

                                TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                            end

                        else

                            getgenv().MUF_sendChatMessage('Unknown Alt')

                        end

                    else

                        if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                            getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                            getgenv().CA_TheBringPosition = Vector3.new(57.99, 11.74, 170.75)

                            getgenv().CA_BringLoopKill = true

                            TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                        end

                    end

                elseif args[3]:lower() == 'basket' then

                    if args[4] then

                        if getgenv().MUF_ReturnClosestPlayer(args[4]) then

                            if getgenv().MUF_ReturnClosestPlayer(args[4]) == game.Players.LocalPlayer then

                                getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                                getgenv().CA_TheBringPosition = Vector3.new(-916.34, 21.99, -521.80)

                                getgenv().CA_BringLoopKill = true

                                TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                            end

                        else

                            getgenv().MUF_sendChatMessage('Unknown Alt')

                        end

                    else

                        if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                            getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                            getgenv().CA_TheBringPosition = Vector3.new(-916.34, 21.99, -521.80)

                            getgenv().CA_BringLoopKill = true

                            TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                        end

                    end

                elseif args[3]:lower() == 'taco' then

                    if args[4] then

                        if getgenv().MUF_ReturnClosestPlayer(args[4]) then

                            if getgenv().MUF_ReturnClosestPlayer(args[4]) == game.Players.LocalPlayer then

                                getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                                getgenv().CA_TheBringPosition = Vector3.new(-272.83, 22.14, -775.72)

                                getgenv().CA_BringLoopKill = true

                                TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                            end

                        else

                            getgenv().MUF_sendChatMessage('Unknown Alt')

                        end

                    else

                        if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                            getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                            getgenv().CA_TheBringPosition = Vector3.new(-272.83, 22.14, -775.72)

                            getgenv().CA_BringLoopKill = true

                            TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                        end

                    end

                elseif args[3]:lower() == 'jail' then

                    if args[4] then

                        if getgenv().MUF_ReturnClosestPlayer(args[4]) then

                            if getgenv().MUF_ReturnClosestPlayer(args[4]) == game.Players.LocalPlayer then

                                getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                                getgenv().CA_TheBringPosition = Vector3.new(-885.489990234375, -38.39921188354492, -613.7000122070312)

                                getgenv().CA_BringLoopKill = true

                                TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                            end

                        else

                            getgenv().MUF_sendChatMessage('Unknown Alt')

                        end

                    else

                        if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                            getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                            getgenv().CA_TheBringPosition = Vector3.new(-885.489990234375, -38.39921188354492, -613.7000122070312)

                            getgenv().CA_BringLoopKill = true

                            TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                        end

                    end

                elseif args[3]:lower() == 'undertrain' then

                    if args[4] then

                        if getgenv().MUF_ReturnClosestPlayer(args[4]) then

                            if getgenv().MUF_ReturnClosestPlayer(args[4]) == game.Players.LocalPlayer then

                                getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                                getgenv().CA_TheBringPosition = Vector3.new(640.5169067382812, 48.49801254272461, -129.74913024902344)

                                getgenv().CA_BringLoopKill = true

                                TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                            end

                        else

                            getgenv().MUF_sendChatMessage('Unknown Alt')

                        end

                    else

                        if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                            getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                            getgenv().CA_TheBringPosition = Vector3.new(640.5169067382812, 48.49801254272461, -129.74913024902344)

                            getgenv().CA_BringLoopKill = true

                            TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                        end

                    end

                elseif args[3]:lower() == 'club' then

                    if args[4] then

                        if getgenv().MUF_ReturnClosestPlayer(args[4]) then

                            if getgenv().MUF_ReturnClosestPlayer(args[4]) == game.Players.LocalPlayer then

                                getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                                getgenv().CA_TheBringPosition = Vector3.new(-262.5199890136719, 0.02936306595802307, -336.42999267578125)

                                getgenv().CA_BringLoopKill = true

                                TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                            end

                        else

                            getgenv().MUF_sendChatMessage('Unknown Alt')

                        end

                    else

                        if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                            getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                            getgenv().CA_TheBringPosition = Vector3.new(-262.5199890136719, 0.02936306595802307, -336.42999267578125)

                            getgenv().CA_BringLoopKill = true

                            TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                        end

                    end

                elseif getgenv().MUF_ReturnClosestPlayer(args[3]) then

                    if args[4] then

                        if getgenv().MUF_ReturnClosestPlayer(args[4]) then

                            if getgenv().MUF_ReturnClosestPlayer(args[4]) == game.Players.LocalPlayer then

                                getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                                getgenv().CA_TheBringPosition = getgenv().MUF_ReturnClosestPlayer(args[3]).Character:FindFirstChild('HumanoidRootPart').Position

                                getgenv().CA_BringLoopKill = true

                                TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                            end

                        else

                            getgenv().MUF_sendChatMessage('Unknown Alt')

                        end

                    else

                        if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                            getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                            getgenv().CA_TheBringPosition = getgenv().MUF_ReturnClosestPlayer(args[3]).Character:FindFirstChild('HumanoidRootPart').Position

                            getgenv().CA_BringLoopKill = true

                            TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                        end

                    end

                end

            else

                if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                    getgenv().MUF_sendChatMessage('Teleporting '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                    getgenv().CA_TheBringPosition = game.Players:FindFirstChild(game.Players:GetNameFromUserIdAsync(tonumber(getgenv().controller))).Character:FindFirstChild('HumanoidRootPart').Position

                    getgenv().CA_BringLoopKill = true

                    TheBringKilling(getgenv().MUF_ReturnClosestPlayer(args[2]))

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Player')

        end

    else

        getgenv().MUF_sendChatMessage('Specify which player to tp')

    end

end

getgenv().HasRunnedAntiStompCMD = true



getgenv().AntiStompCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if game.Players.LocalPlayer == getgenv().MUF_ReturnClosestPlayer(args[2]) then

                if getgenv().CA_AntiStomp == false then

                    getgenv().MUF_sendChatMessage('Enabled Anti Stomp')

                    getgenv().CA_AntiStomp = true

                    local LF_Loop

                    local LF_loopFunction = function()

                        if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid').Health < 99 then

                            getgenv().PlayersService.RespawnTime = -1

                            game.Players.LocalPlayer.Character:BreakJoints()

                            game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid').Health = 0

                            getgenv().CA_AntiStomp = false

                        end

                    end;

                    local LF_Start = function()

                        LF_Loop = RunService.Heartbeat:Connect(LF_loopFunction);

                    end;

                    local LF_Pause = function()

                        LF_Loop:Disconnect()

                        getgenv().MUF_sendChatMessage('Disabled Anti Stomp')

                    end;

                

                    LF_Start()

                    repeat wait() until getgenv().CA_AntiStomp == false

                    LF_Pause()

                else

                    getgenv().CA_AntiStomp = false

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        if getgenv().CA_AntiStomp == false then

            getgenv().MUF_sendChatMessage('Enabled Anti Stomp')

            getgenv().CA_AntiStomp = true

            local LF_Loop

            local LF_loopFunction = function()

                if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid').Health < 99 then

                    getgenv().PlayersService.RespawnTime = -1

                    game.Players.LocalPlayer.Character:BreakJoints()

                    game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid').Health = 0

                    getgenv().CA_AntiStomp = false

                end

            end;

            local LF_Start = function()

                LF_Loop = RunService.Heartbeat:Connect(LF_loopFunction);

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                getgenv().MUF_sendChatMessage('Disabled Anti Stomp')

            end;

        

            LF_Start()

            repeat wait() until getgenv().CA_AntiStomp == false

            LF_Pause()

        else

            getgenv().MUF_sendChatMessage('Disabled Anti Stomp')

            getgenv().CA_AntiStomp = false

        end

    end

end

getgenv().HasRunnedAutoStompCMD = true



getgenv().AutoStompCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if game.Players.LocalPlayer == getgenv().MUF_ReturnClosestPlayer(args[2]) then

                if getgenv().CA_AutoStomp == false then

                    getgenv().MUF_sendChatMessage('Enabled Auto Stomp')

                    getgenv().CA_AutoStomp = true

                    local LF_Loop

                    local LF_loopFunction = function()

                        game.ReplicatedStorage.MainEvent:FireServer("Stomp")

                    end;

                    local LF_Start = function()

                        LF_Loop = RunService.Heartbeat:Connect(LF_loopFunction);

                    end;

                    local LF_Pause = function()

                        LF_Loop:Disconnect()

                        getgenv().MUF_sendChatMessage('Stopped Auto Stomp')

                    end;

                

                    LF_Start()

                    repeat wait() until getgenv().CA_AutoStomp == false

                    LF_Pause()

                else

                    getgenv().CA_AutoStomp = false

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        if getgenv().CA_AutoStomp == false then

            getgenv().MUF_sendChatMessage('Enabled Auto Stomp')

            getgenv().CA_AutoStomp = true

            local LF_Loop

            local LF_loopFunction = function()

                game.ReplicatedStorage.MainEvent:FireServer("Stomp")

            end;

            local LF_Start = function()

                LF_Loop = RunService.Heartbeat:Connect(LF_loopFunction);

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                getgenv().MUF_sendChatMessage('Stopped Auto Stomp')

            end;

        

            LF_Start()

            repeat wait() until getgenv().CA_AutoStomp == false

            LF_Pause()

        else

            getgenv().CA_AutoStomp = false

        end

    end

end

getgenv().HasRunnedAntiBagCMD = true



getgenv().AntiBagCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if game.Players.LocalPlayer == getgenv().MUF_ReturnClosestPlayer(args[2]) then

                if getgenv().CA_AntiBag == false then

                    getgenv().MUF_sendChatMessage('Enabled Anti Bag')

                    getgenv().CA_AntiBag = true

                    local LF_Loop

                    local LF_loopFunction = function()

                        if game.Players.LocalPlayer.Character:FindFirstChild('Christmas_Sock') then

                            game.Players.LocalPlayer.Character:FindFirstChild('Christmas_Sock'):Destroy() 

                            getgenv().CA_AntiBag = false

                        end

                    end;

                    local LF_Start = function()

                        LF_Loop = RunService.Heartbeat:Connect(LF_loopFunction);

                    end;

                    local LF_Pause = function()

                        LF_Loop:Disconnect()

                        getgenv().MUF_sendChatMessage('Disabled Anti Bag')

                    end;

                

                    LF_Start()

                    repeat wait() until getgenv().CA_AntiBag == false

                    LF_Pause()

                else

                    getgenv().CA_AntiBag = false

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        if getgenv().CA_AntiBag == false then

            getgenv().MUF_sendChatMessage('Enabled Anti Bag')

            getgenv().CA_AntiBag = true

            local LF_Loop

            local LF_loopFunction = function()

                if game.Players.LocalPlayer.Character:FindFirstChild('Christmas_Sock') then

                    game.Players.LocalPlayer.Character:FindFirstChild('Christmas_Sock'):Destroy() 

                    getgenv().CA_AntiBag = false

                end

            end;

            local LF_Start = function()

                LF_Loop = RunService.Heartbeat:Connect(LF_loopFunction);

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                getgenv().MUF_sendChatMessage('Disabled Anti Bag')

            end;

        

            LF_Start()

            repeat wait() until getgenv().CA_AntiBag == false

            LF_Pause()

        else

            getgenv().CA_AntiBag = false

        end

    end

end

getgenv().HasRunnedFlingCMD = true



getgenv().FlingCMD = function(args)

    if getgenv().CA_IsNoClipping == true then

        return getgenv().MUF_sendChatMessage('You must disable noclip first in order to use this')

    end

    if getgenv().CA_IsFreezing == true then

        getgenv().CA_IsFreezing = false

        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

    end

    if getgenv().CA_IsAirlocking == true then

        getgenv().CA_IsAirlocking = false

        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

    end

    if getgenv().CA_IsGraving == true then

        getgenv().CA_IsGraving = false

        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

    end

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if args[3] then

                if getgenv().MUF_ReturnClosestPlayer(args[3]) then

                    if getgenv().MUF_ReturnClosestPlayer(args[3]) == game.Players.LocalPlayer then

                        if getgenv().CA_IsLoopFlinging == false then

                            getgenv().MUF_sendChatMessage('Started Loop Flinging '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                            getgenv().CA_IsLoopFlinging = true

                            local LF_Loop

                            local LF_loopFunction = function(FlingEnemy)

                                FlingTorso = FlingEnemy.Character:FindFirstChild('HumanoidRootPart')

                                local dis = 3.85

                                local increase = 6

                                if FlingEnemy.Character.Humanoid.MoveDirection.X < 0 then

                                    xchange = -increase

                                elseif FlingEnemy.Character.Humanoid.MoveDirection.X > 0  then

                                    xchange = increase

                                else

                                    xchange = 0

                                end

                                if FlingEnemy.Character.Humanoid.MoveDirection.Z < 0 then

                                    zchange = -increase

                                elseif FlingEnemy.Character.Humanoid.MoveDirection.Z > 0 then

                                    zchange = increase

                                else

                                    zchange = 0

                                end          

                                if game.Players.LocalPlayer.Character then

                                    game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid'):ChangeState(11)

                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(FlingTorso.Position.X + math.random(-dis,dis) + xchange, FlingTorso.Position.Y, FlingTorso.Position.Z + math.random(-dis,dis) + zchange) * CFrame.Angles(math.rad(game.Players.LocalPlayer.Character.HumanoidRootPart.Orientation.X + 350),math.rad(game.Players.LocalPlayer.Character.HumanoidRootPart.Orientation.Y + 200),math.rad(game.Players.LocalPlayer.Character.HumanoidRootPart.Orientation.Z + 240))

                                    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(500000,500000,500000)

                                end

                                wait(0.05)

                            end;

                            local LF_Start = function(FlingEnemy)

                                LF_Loop = RunService.Heartbeat:Connect(function()

                                    LF_loopFunction(FlingEnemy)

                                end)

                            end;

                            local LF_Pause = function()

                                LF_Loop:Disconnect()

                                getgenv().MUF_sendChatMessage('Stopped Flinging')

                            end;

                        

                            LF_Start(getgenv().MUF_ReturnClosestPlayer(args[2]))

                            repeat wait() until getgenv().CA_IsLoopFlinging == false

                            LF_Pause()

                        else

                            getgenv().CA_IsLoopFlinging = false

                            wait(0.2)

                            game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = game.Players:FindFirstChild(game.Players:GetNameFromUserIdAsync(tonumber(getgenv().controller))).Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(4, 0, 0)

                        end

                    end

                end

            else

                if game.Players.LocalPlayer.UserId == getgenv().alts['Alt1'] then

                    if getgenv().CA_IsLoopFlinging == false then

                        getgenv().MUF_sendChatMessage('Started Loop Flinging '..getgenv().MUF_ReturnClosestName(args[2])..'!')

                        getgenv().CA_IsLoopFlinging = true

                        local LF_Loop

                        local LF_loopFunction = function(FlingEnemy)

                            FlingTorso = FlingEnemy.Character:FindFirstChild('HumanoidRootPart')

                            local dis = 3.85

                            local increase = 6

                            if FlingEnemy.Character.Humanoid.MoveDirection.X < 0 then

                                xchange = -increase

                            elseif FlingEnemy.Character.Humanoid.MoveDirection.X > 0  then

                                xchange = increase

                            else

                                xchange = 0

                            end

                            if FlingEnemy.Character.Humanoid.MoveDirection.Z < 0 then

                                zchange = -increase

                            elseif FlingEnemy.Character.Humanoid.MoveDirection.Z > 0 then

                                zchange = increase

                            else

                                zchange = 0

                            end          

                            if game.Players.LocalPlayer.Character then

                                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid'):ChangeState(11)

                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(FlingTorso.Position.X + math.random(-dis,dis) + xchange, FlingTorso.Position.Y, FlingTorso.Position.Z + math.random(-dis,dis) + zchange) * CFrame.Angles(math.rad(game.Players.LocalPlayer.Character.HumanoidRootPart.Orientation.X + 350),math.rad(game.Players.LocalPlayer.Character.HumanoidRootPart.Orientation.Y + 200),math.rad(game.Players.LocalPlayer.Character.HumanoidRootPart.Orientation.Z + 240))

                                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(500000,500000,500000)

                            end

                            wait(0.05)

                        end;

                        local LF_Start = function(FlingEnemy)

                            LF_Loop = RunService.Heartbeat:Connect(function()

                                LF_loopFunction(FlingEnemy)

                            end)

                        end;

                        local LF_Pause = function()

                            LF_Loop:Disconnect()

                            getgenv().MUF_sendChatMessage('Stopped Flinging')

                        end;

                    

                        LF_Start(getgenv().MUF_ReturnClosestPlayer(args[2]))

                        repeat wait() until getgenv().CA_IsLoopFlinging == false

                        LF_Pause()

                    else

                        getgenv().CA_IsLoopFlinging = false

                        wait(0.2)

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = game.Players:FindFirstChild(game.Players:GetNameFromUserIdAsync(tonumber(getgenv().controller))).Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(4, 0, 0)

                    end

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Player')

        end

    end

end

getgenv().HasRunnedSpinCMD = true



getgenv().SpiNCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if game.Players.LocalPlayer == getgenv().MUF_ReturnClosestPlayer(args[2]) then

                if getgenv().CA_IsSpinning == false then

                    getgenv().MUF_sendChatMessage('Started Spinning!')

                    getgenv().CA_IsSpinning = true

                    local LF_Loop

                    local LF_loopFunction = function()

                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(50), 0)

                    end;

                    local LF_Start = function()

                        LF_Loop = RunService.Heartbeat:Connect(LF_loopFunction);

                    end;

                    local LF_Pause = function()

                        LF_Loop:Disconnect()

                        getgenv().MUF_sendChatMessage('Stopped Spinning')

                    end;

                

                    LF_Start()

                    repeat wait() until getgenv().CA_IsSpinning == false

                    LF_Pause()

                else

                    getgenv().CA_IsSpinning = false

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        if getgenv().CA_IsSpinning == false then

            getgenv().MUF_sendChatMessage('Started Spinning!')

            getgenv().CA_IsSpinning = true

            local LF_Loop

            local LF_loopFunction = function()

                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(50), 0)

            end;

            local LF_Start = function()

                LF_Loop = RunService.Heartbeat:Connect(LF_loopFunction);

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                getgenv().MUF_sendChatMessage('Stopped Spinning')

            end;

        

            LF_Start()

            repeat wait() until getgenv().CA_IsSpinning == false

            LF_Pause()

        else

            getgenv().CA_IsSpinning = false

        end

    end

end

getgenv().HasRunnedGrabCMD = true



getgenv().GrabCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if game.Players.LocalPlayer == getgenv().MUF_ReturnClosestPlayer(args[2]) then

                game.ReplicatedStorage.MainEvent:FireServer("Grabbing")

                getgenv().MUF_sendChatMessage('Toggled Grabbing')

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        game.ReplicatedStorage.MainEvent:FireServer("Grabbing")

        getgenv().MUF_sendChatMessage('Toggled Grabbing')

    end

end

getgenv().HasRunnedAntiArrestCMD = true



getgenv().AntiArrestCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if game.Players.LocalPlayer == getgenv().MUF_ReturnClosestPlayer(args[2]) then

                if getgenv().CA_AntiArrest == false then

                    getgenv().MUF_sendChatMessage('Enabled Anti Arrest')

                    getgenv().CA_AntiArrest = true

                    local LF_Loop

                    local LF_loopFunction = function()

                        for _,v in pairs(game:GetService('Players'):GetChildren()) do

                            if v.Character and v.DataFolder.Officer.Value == 1 then

                                if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 and game.Players.LocalPlayer.Character.BodyEffects['K.O'].Value == true then

                                    game.Players.LocalPlayer.Character:Destroy()

                                end

                            end

                        end

                    end;

                    local LF_Start = function()

                        LF_Loop = RunService.Heartbeat:Connect(LF_loopFunction);

                    end;

                    local LF_Pause = function()

                        LF_Loop:Disconnect()

                        getgenv().MUF_sendChatMessage('Disabled Anti Arrest')

                    end;

                

                    LF_Start()

                    repeat wait() until getgenv().CA_AntiArrest == false

                    LF_Pause()

                else

                    getgenv().CA_AntiArrest = false

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        if getgenv().CA_AntiArrest == false then

            getgenv().MUF_sendChatMessage('Enabled Anti Stomp')

            getgenv().CA_AntiArrest = true

            local LF_Loop

            local LF_loopFunction = function()

                for _,v in pairs(game:GetService('Players'):GetChildren()) do

                    if v.Character and v.DataFolder.Officer.Value == 1 then

                        if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 and game.Players.LocalPlayer.Character.BodyEffects['K.O'].Value == true then

                            game.Players.LocalPlayer.Character:Destroy()

                        end

                    end

                end

            end;

            local LF_Start = function()

                LF_Loop = RunService.Heartbeat:Connect(LF_loopFunction);

            end;

            local LF_Pause = function()

                LF_Loop:Disconnect()

                getgenv().MUF_sendChatMessage('Disabled Anti Arrest')

            end;

        

            LF_Start()

            repeat wait() until getgenv().CA_AntiArrest == false

            LF_Pause()

        else

            getgenv().CA_AntiArrest = false

        end

    end

end

getgenv().HasRunnedSitCMD = true



getgenv().SitCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if game.Players.LocalPlayer == getgenv().MUF_ReturnClosestPlayer(args[2]) then

                if game.Players.LocalPlayer.Character.Humanoid.Sit == false then

                    game.Players.LocalPlayer.Character.Humanoid.Sit = true

                else

                    game.Players.LocalPlayer.Character.Humanoid.Sit = false

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        if game.Players.LocalPlayer.Character.Humanoid.Sit == false then

            game.Players.LocalPlayer.Character.Humanoid.Sit = true

        else

            game.Players.LocalPlayer.Character.Humanoid.Sit = false

        end

    end

end

getgenv().HasRunnedSpyCMD = true



getgenv().SpyCMD = function()

    local chatFrame = game:GetService('Players').LocalPlayer.PlayerGui.Chat.Frame

    if chatFrame.ChatChannelParentFrame.Visible == false then

        chatFrame.ChatChannelParentFrame.Visible = true

        chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y)

    else

        chatFrame.ChatChannelParentFrame.Visible = false

        chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y)

    end

end

getgenv().HasRunnedDonateCMD = true



getgenv().DonateCMD = function(gamePassId)

    MarketplaceService:PromptGamePassPurchase(game.Players.LocalPlayer, 54210788)

end
