import React from 'react';
import { Button, Card, Container, Row, Col, Stack } from 'react-bootstrap';

function World() {
    console.log("World");
    return (
        <Container>
            <Row xs={1} md={2} className="g-4">
                {Array.from({ length: 4 }).map((_, idx) => (
                    <Col>
                        <Card>
                            <Card.Img variant="top" src="images/support.png" />
                            <Card.Body>
                                <Card.Title>제목: Title</Card.Title>
                                <Card.Text>
                                    작품 설명: Description
                                </Card.Text>
                                <Card.Text>
                                    크리에이터: Creator
                                </Card.Text>
                                <Card.Text>
                                    현재가: 1 ETH ({'\u2252'} ₩42,500)
                                </Card.Text>
                                <Stack direction="horizontal" gap={3}>
                                    <Button onClick={''} variant="primary">구매</Button>
                                    <Button onClick={''} variant="primary">조회</Button>
                                </Stack>
                            </Card.Body>
                        </Card>
                    </Col>
                ))}
            </Row>
        </Container>
    )
}

export default World;
