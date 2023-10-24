"use client"

import { useMemo, useEffect, useRef } from 'react';
import { initScene, initLoop } from './boids';

const canvasContainerId = "canvas-container";
const CANVAS_HEIGHT = 600;

const Canvas = () => {
    const { scene, camera, renderer } = useMemo(() => {
        return initScene();
    }, []);

    useEffect(() => {
        // set renderer dimensions and add it to the dom
        const containerRef = useRef(null);
        if(!containerRef) return null;
        const [ canvasWidth, canvasHeight ] = [ containerRef.clientWidth || window.innerWidth, CANVAS_HEIGHT ];
        renderer.setSize( canvasWidth, canvasHeight );
        containerRef.replaceChildren( renderer.domElement );
        const loop = initLoop(scene, camera);

        const animate = () => {
            loop();
            requestAnimationFrame( animate );
        
            renderer.render( scene, camera );
        }
        animate();

    }, [camera, renderer, scene]);

    if(!window || !document) return null;
    return <div id={canvasContainerId} ref={containerRef}/>;
};

export default Canvas;