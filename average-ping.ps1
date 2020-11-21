$ipAddr = $args[0]
$maxPingRequests = $args[1]

$question = 'Would you like to run again?'
$choices  = '&Yes', '&No'


function isInt($value) {
    return $value -match "^\d+$"
}

function displayMessage($msg) {
    echo $msg
}

function quitWithReason($reason) {
    echo "Quitting because: $reason"
    Exit Script
}

if($maxPingRequests -and $ipAddr) {

    $isRunning = 1;
    Do{
        $sum = 0;
        $maximum = 0;
        $minimum = 0;

        For($i=0; $i -lt $maxPingRequests; $i++) {
            $pingResult = Test-Connection $ipAddr -Count 1
            $response = ($pingResult | Measure-Object -Average -Maximum -Minimum ResponseTime)
            $sum += $response.Average
        
            $tmpMaximum = $response.Maximum
            $tmpMinimum =  $response.Minimum

            if($minimum -eq 0) {
                $minimum = $tmpMinimum
            }
        
            if($tmpMaximum -gt $maximum) {
                $maximum = $tmpMaximum
            }

            if($tmpMinimum -lt $minimum) {
                $minimum = $tmpMinimum
            }

            echo($pingResult)
        }
        $average = ($sum/$maxPingRequests)

        echo("`nCount`t: $maxPingRequests")
        echo("Average`t: $average")
        echo("Maximum`t: $maximum")
        echo("Minimum`t: $minimum`n")

        $decision = $Host.UI.PromptForChoice('', $question, $choices, 1)
        if ($decision -eq 1) {
            $isRunning = 0   
        } else {
            echo ""
        }
    } While($isRunning -eq 1)
    
} else {
    echo "Please provide the IP_ADDRESS to ping and the AMOUNT_OF_REQUESTS you'd like to make"
}
