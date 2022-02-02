import React, { useState } from 'react';
import { Container, Card, Form, Button } from 'react-bootstrap';
import { ethers } from 'ethers';

function Create() {
    console.log("Create");
    const [imageSrc, setImageSrc] = useState('');
    const encodeFileToBase64 = (fileBlob) => {
        const reader = new FileReader();
        reader.readAsDataURL(fileBlob);
        return new Promise((resolve) => {
            reader.onload = () => {
                setImageSrc(reader.result);
                resolve();
            }
        });
    };

    function handleImageUpload(event) {
        encodeFileToBase64(event.target.files[0]);
    }

    return (
        <Container className='centered'>
            <Card style={{ width: '18rem' }}>
                <Card.Header className='centered'>NFT 생성</Card.Header>
                <Card.Body className="centered">
                    <div className="preview" id="preview">
                        {imageSrc && <img src={imageSrc} alt="" />}
                    </div>
                </Card.Body>
                <Card.Body className="centered">
                    <Form>
                        <Form.Group>
                            <Form.Label className="label centered" id="label" htmlFor="input">
                                <Button variant="primary" className="inner" id="inner" disabled>파일 업로드</Button>
                            </Form.Label>
                            <Form.Control id="input" className="input" accept="image/*" type="file" onChange={handleImageUpload} required={true} hidden={true} />
                        </Form.Group>

                        <Form.Group className="mb-3" controlId='formBasicText'>
                            <Form.Label>
                                제목
                            </Form.Label>
                            <Form.Control type="text" placeholder="Title" />
                        </Form.Group>

                        <Form.Group className="mb-3" controlId='formBasicText'>
                            <Form.Label>
                                설명
                            </Form.Label>
                            <Form.Control as="textarea" placeholder="Description" />
                        </Form.Group>

                        <Form.Group className="centered">
                            <Button variant="primary" type="submit">생성</Button>
                        </Form.Group>
                    </Form>
                </Card.Body>
            </Card>
        </Container>
    )
}


export default Create;