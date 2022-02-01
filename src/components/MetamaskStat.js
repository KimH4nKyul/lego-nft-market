import React from 'react';
import { Button } from 'react-bootstrap';
import { useMetaMask } from 'metamask-react';

function openMetamaskDownload() {
    const link = 'https://metamask.io/download/';
    window.open(link);
}

function MetamaskStat() {
    console.log("MetamaskStat")
    const { status, connect, account } = useMetaMask();
    // if (status === "initializing")
    //     return <div>Synchronisation with MetaMask ongoing...</div>

    if (status === "unavailable") {

        return < Button variant="danger" onClick={openMetamaskDownload}>
            Need Metamask, Clik me.
        </ Button >
    }

    if (status === "notConnected")
        return <Button variant="warning" onClick={connect}>
            Connect to MetaMask
        </Button>

    if (status === "connecting")
        return <Button variant="warning" disabled>
            Connecting
        </Button>

    if (status === "connected")
        return <Button variant="primary" disabled>
            Connected: {account.substring(0, 7)}
        </Button>

    return null;
}

export default MetamaskStat;
