import React from 'react';
import { Container, Navbar, Nav, Button } from 'react-bootstrap';
import MetamaskStat from './MetamaskStat';

function Menu() {
    return (

        <Navbar bg="light" expand="lg">
            <Container>
                <Navbar.Brand><img alt="" src="images/lego_logo_small.png"></img></Navbar.Brand>
                <Navbar.Toggle aria-controls="basic-navbar-nav" />
                <Navbar.Collapse id="basic-navbar-nav">
                    <Nav className="me-auto">
                        <Nav.Link href="/world">
                            <Button variant="primary">Market</Button>
                        </Nav.Link>
                        <Nav.Link href="/create">
                            <Button variant="primary">Create</Button>
                        </Nav.Link>
                        <Nav.Link href="/about">
                            <Button variant="primary">About</Button>
                        </Nav.Link>
                    </Nav>
                </Navbar.Collapse>
                <MetamaskStat />
            </Container>
        </Navbar>

    )
}

export default Menu;